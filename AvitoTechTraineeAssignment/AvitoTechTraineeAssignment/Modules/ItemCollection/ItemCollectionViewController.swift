//
//  ItemCollectionViewController.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import UIKit

// MARK: constants for view

fileprivate enum Constants {
    static let cellOffset: CGFloat = 10
    static let cellHeight: CGFloat = 250
}

final class ItemCollectionViewController: UIViewController {
    
    // MARK: VIPER properties
    
    private let output: ItemCollectionViewOutput

    // MARK: logic properties
    
    private var registrationCache: [String: Bool] = [:]
    private var inSearchMode: Bool = false
    
    // MARK: UI properties
    
    private var entitySegmentedController = UISegmentedControl()
    private var limitSegmentedController = UISegmentedControl()
    
    private let statusLabel = UILabel()
    
    private let searchResultTableView = UITableView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }()
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: init methods
    
    init(output: ItemCollectionViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        view.backgroundColor = .white
    }
}

// MARK: - all vc input methods

extension ItemCollectionViewController: ItemCollectionViewInput {
    
    func handle(_ event: ViewEvents) {
        switch event {
        case .success(let term):
            handleSuccess(term: term)
        case .loading:
            handleLoading()
        case .error(let error):
            handleError(error: error)
        }
    }
    
    func reloadSearchData() {
        searchResultTableView.reloadData()
    }
    
    private func handleError(error: String) {
        showAlert(with: error)
        statusLabel.text = "Error"
        collectionView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    private func showAlert(with error: String) {
        let alert = UIAlertController(title: "Sorry", message: "Some error: \(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleSuccess(term: String) {
        statusLabel.text = term
        collectionView.reloadData()
        if !inSearchMode {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.collectionView.alpha = 1
            }, completion: { [weak self] _ in
                self?.collectionView.isHidden = false
            })
        }
        activityIndicatorView.stopAnimating()
    }
    
    private func handleLoading() {
        statusLabel.text = "Loading"
        collectionView.isHidden = true
        activityIndicatorView.startAnimating()
        endSearch()
    }
}

// MARK: - all ui setup methods

private extension ItemCollectionViewController {
    
    func setup() {
        setupNavigationController()
        setupSegmentedControlleres()
        setupLabel()
        setupSearchBar()
        setupActivityIndicatorView()
        setupCollectionView()
        setupTableView()
    }
    
    func setupSegmentedControlleres() {
        
        entitySegmentedController = UISegmentedControl(items: output.entityTypes())
        limitSegmentedController = UISegmentedControl(items: output.limitTypes())
        
        [entitySegmentedController, limitSegmentedController].forEach {
            $0.isHidden = true
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.selectedSegmentIndex = 0
        }
        
        NSLayoutConstraint.activate([
            entitySegmentedController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            entitySegmentedController.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            entitySegmentedController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            limitSegmentedController.topAnchor.constraint(equalTo: entitySegmentedController.safeAreaLayoutGuide.bottomAnchor),
            limitSegmentedController.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            limitSegmentedController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    func setupActivityIndicatorView() {
        
        activityIndicatorView.hidesWhenStopped = true
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    func setupTableView() {
        
        searchResultTableView.backgroundColor = .clear
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
        
        view.addSubview(searchResultTableView)
        searchResultTableView.translatesAutoresizingMaskIntoConstraints = false
        searchResultTableView.isHidden = true
        
        NSLayoutConstraint.activate([
            searchResultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchResultTableView.topAnchor.constraint(equalTo: limitSegmentedController.bottomAnchor),
            searchResultTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    func setupLabel() {
        
        statusLabel.text = "No results"
        statusLabel.numberOfLines = 1
        statusLabel.textAlignment = .center
        
        view.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    func setupSearchBar() {
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Let's search something"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.sizeToFit()
    }
    
    func setupCollectionView() {
        
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Constants.cellOffset),
            collectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    func setupNavigationController() {
        
        title = "iTunes Search"
    }
}

// MARK: - UICollectionView methods

extension ItemCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item: Item = output.item(at: indexPath.row)
        
        if registrationCache[item.cellType.reusableIdentifier] == nil {
            collectionView.register(item.cellType, forCellWithReuseIdentifier: item.cellType.reusableIdentifier)
            registrationCache[item.reusableIdentifier] = true
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reusableIdentifier,
                                                            for: indexPath) as? (any ReusableCollectionCell) else {
            return UICollectionViewCell()
        }
        
        item.configurationCell(cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.itemAmount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width - Constants.cellOffset * (2 + 1)
        let cellWidth = availableWidth / 2
        
        return .init(width: cellWidth, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 0, left: Constants.cellOffset, bottom: 0, right: Constants.cellOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didTapOnCell(with: indexPath.row)
    }
}

// MARK: - UISearchController methods

extension ItemCollectionViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func presentSearchController(_ searchController: UISearchController) {
        startSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        output.searchForItems(term: text,
                              entityIndex: entitySegmentedController.selectedSegmentIndex,
                              limitIndex: limitSegmentedController.selectedSegmentIndex)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endSearch()
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.collectionView.alpha = 1
            self?.statusLabel.alpha = 1
        }, completion: { [weak self] _ in
            self?.collectionView.isHidden = false
            self?.statusLabel.isHidden = false
        })
    }
    
    func startSearch() {
        inSearchMode = true
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.collectionView.alpha = 0
            self?.searchResultTableView.alpha = 1
            self?.entitySegmentedController.alpha = 1
            self?.limitSegmentedController.alpha = 1
            self?.statusLabel.alpha = 0
        }, completion: { [weak self] _ in
            self?.collectionView.isHidden = true
            self?.searchResultTableView.isHidden = false
            self?.entitySegmentedController.isHidden = false
            self?.limitSegmentedController.isHidden = false
            self?.statusLabel.isHidden = true
        })
    }
    
    func endSearch() {
        inSearchMode = false
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.searchResultTableView.alpha = 0
            self?.entitySegmentedController.alpha = 0
            self?.limitSegmentedController.alpha = 0
            self?.statusLabel.alpha = 1
        }, completion: { [weak self] _ in
            self?.searchResultTableView.isHidden = true
            self?.entitySegmentedController.isHidden = true
            self?.limitSegmentedController.isHidden = true
            self?.statusLabel.isHidden = false
        })
        searchController.isActive = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        output.searchFilter(with: text)
    }
}

// MARK: - UITableView methods

extension ItemCollectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.searchTipsAmount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        cell.textLabel?.text = output.searchTip(at: indexPath.row)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.searchBar.text = output.searchTip(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if output.searchTipsAmount() > 0 {
            return "Search history"
        } else {
            return nil
        }
    }
}
