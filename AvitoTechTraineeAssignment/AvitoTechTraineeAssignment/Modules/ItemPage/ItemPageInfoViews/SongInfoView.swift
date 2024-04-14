//
//  SongInfoView.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation
import UIKit

fileprivate enum Constants {
    static let imageHeight: CGFloat = 100
    static let borderOffset: CGFloat = 5
}

final class SongInfoView: UIView, ConformingView {
    
    private var model: Song?
    
    // MARK: ui properties
    
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let imageView = UIImageView()
    private let artistNameLabel = UILabel()
    private let itemLinkButton = UIButton(type: .system)
    private let descriptionLabel = UILabel()
    
    //MARK: init methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: methods
    
    func configure(with model: Song) {
        self.model = model
        nameLabel.text = "Name: \(model.name)"
        typeLabel.text = "Type: \(model.wrapperType) \(model.kind)"
        artistNameLabel.text = "Author: \(model.artistName)"
        descriptionLabel.text = "Description: Song type has no description in data from API, but is has primaryGenreName: \(model.primaryGenreName)"
        imageView.image = model.getImageOf()
        setup()
    }
    
    private func setup() {
        setupNameLabel()
        setupTypeLabel()
        setupItemLinkButton()
        setupArtistNameLabel()
        setupDescription()
        setupImageView()
        setupConstraints()
    }
    
    private func setupNameLabel() {
        nameLabel.numberOfLines = 0
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTypeLabel() {
        nameLabel.numberOfLines = 0
        addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false    }
    
    private func setupItemLinkButton() {
        itemLinkButton.setTitle("Go to source", for: .normal)
        itemLinkButton.addTarget(self, action: #selector(openItemLink), for: .touchUpInside)
        
        addSubview(itemLinkButton)
        itemLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupArtistNameLabel() {
        artistNameLabel.numberOfLines = 0
        addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDescription() {
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            itemLinkButton.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            itemLinkButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            itemLinkButton.bottomAnchor.constraint(lessThanOrEqualTo: descriptionLabel.topAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            
            typeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor),
            artistNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: descriptionLabel.topAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    private func openItemLink() {
        guard let url = URL(string: model?.viewUrl ?? "") else {
            return
        }
        UIApplication.shared.open(url)
    }
}
