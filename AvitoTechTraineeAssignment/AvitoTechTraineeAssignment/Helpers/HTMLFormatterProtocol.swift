//
//  HTMLFormatterProtocol.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation

protocol HTMLFormatterProtocol {
    
}

extension HTMLFormatterProtocol {
    
    func formate(text: String) -> String {
        guard let data = text.data(using: .utf16) else {
            return ""
        }
        guard let attributedString = try? NSAttributedString(data: data,
                                                             options: [.documentType: NSAttributedString.DocumentType.html],
                                                             documentAttributes: nil) else {
            return ""
        }
        return attributedString.string
    }
}
