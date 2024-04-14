//
//  ArtistInfoView.swift
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

final class ArtistInfoView: UIView {
    
    private var model: ArtistDescription?
    
    // MARK: ui properties

    private let artistLabel = UILabel()
    private let artistNameLabel = UILabel()
    private let artistIdLabel = UILabel()
    private let artistLinkButton = UIButton(type: .system)
    
    //MARK: init methods
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: methods
    
    func configure(with model: ArtistDescription) {
        self.model = model
        artistNameLabel.text = "Name: \(model.artistName)"
        artistIdLabel.text = "Id: \(model.artistId)"
    }
    
    private func setup() {
        setupLabel()
        setupNameLabel()
        setupIdLabel()
        setupItemLinkButton()
        setupConstraints()
    }
    
    private func setupLabel() {
        artistLabel.text = "Artist:"
        addSubview(artistLabel)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupNameLabel() {
        artistNameLabel.numberOfLines = 0
        addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupIdLabel() {
        artistIdLabel.numberOfLines = 0
        addSubview(artistIdLabel)
        artistIdLabel.translatesAutoresizingMaskIntoConstraints = false    }
    
    private func setupItemLinkButton() {
        artistLinkButton.setTitle("Go to source", for: .normal)
        artistLinkButton.addTarget(self, action: #selector(openItemLink), for: .touchUpInside)
        
        addSubview(artistLinkButton)
        artistLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            artistLabel.topAnchor.constraint(equalTo: topAnchor),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor),
            
            artistIdLabel.leadingAnchor.constraint(equalTo: artistNameLabel.leadingAnchor),
            artistIdLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor),
            
            artistLinkButton.leadingAnchor.constraint(equalTo: artistNameLabel.leadingAnchor),
            artistLinkButton.topAnchor.constraint(equalTo: artistIdLabel.bottomAnchor),
            artistLinkButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc
    private func openItemLink() {
        guard let url = URL(string: model?.artistLinkUrl ?? "") else {
            return
        }
        UIApplication.shared.open(url)
    }
}
