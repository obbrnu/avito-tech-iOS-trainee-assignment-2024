//
//  SongCollectionViewCell.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 13.04.2024.
//

import Foundation
import UIKit

fileprivate enum Constants {
    static let imageHeight: CGFloat = 130
    static let borderOffset: CGFloat = 5
}

final class SongCollectionViewCell: UICollectionViewCell, ReusableCollectionCell {
    
    // MARK: ui properties
    
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let imageView = UIImageView()
    
    //MARK: init methods
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: methods
    
    func configure(with model: Song) {
        nameLabel.text = model.name
        typeLabel.text = "\(model.wrapperType) \(model.kind)"
        imageView.image = model.getImageOf()
    }
    
    private func setup() {
        contentView.backgroundColor = .blue.withAlphaComponent(0.5)
        setupTypeLabel()
        setupImage()
        setupNameLabel()
    }
    
    private func setupNameLabel() {
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.borderOffset),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.borderOffset)
        ])
    }
    
    private func setupImage() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: "film.circle.fill")
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageHeight),
        ])
    }
    
    private func setupTypeLabel() {
        typeLabel.textAlignment = .center
        
        contentView.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeLabel.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            typeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constants.borderOffset)
        ])
    }
}
