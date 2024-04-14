//
//  ItemPageViewController.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import UIKit

final class ItemPageViewController: UIViewController {
    private let output: ItemPageViewOutput

    private let item: Item
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var infoView: any ConformingView
    private var artistView = ArtistInfoView()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    init(output: ItemPageViewOutput, item: Item) {
        self.output = output
        self.item = item
        infoView = item.configurationView()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.loadArtist(with: item.model.artistId)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        setup()
    }
    
    private func setup() {
        setupScrollView()
        setupInfoView()
        setupArtist()
        setupActivityIndicatorView()
    }
    
    private func setupArtist() {
        artistView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(artistView)
        NSLayoutConstraint.activate([
            artistView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 10),
            artistView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            artistView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            artistView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicatorView() {
        
        activityIndicatorView.hidesWhenStopped = true
        
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: artistView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: artistView.centerYAnchor),
        ])
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupInfoView() {
        infoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupArtistInfoView() {
        infoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            infoView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    
}

extension ItemPageViewController: ItemPageViewInput {
    
    func handle(_ event: ViewEvents) {
        switch event {
        case .success(_):
            handleSuccess()
        case .loading:
            handleLoading()
        case .error(let error):
            handleError(error: error)
        }
    }
    
    private func handleError(error: String) {
        showAlert(with: error)
        activityIndicatorView.stopAnimating()
        artistView.isHidden = true
    }
    
    private func showAlert(with error: String) {
        let alert = UIAlertController(title: "Sorry", message: "Some error: \(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleSuccess() {
        activityIndicatorView.stopAnimating()
        artistView.configure(with: output.getArtist())
        artistView.isHidden = false
        setup()
    }
    
    private func handleLoading() {
        activityIndicatorView.startAnimating()
        artistView.isHidden = true
    }
    
}
