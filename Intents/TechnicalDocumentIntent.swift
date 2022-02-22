//
//  TechnicalDocumentIntent.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import Foundation

public enum TechnicalDocumentIntent: Equatable{
    case ready
    case editingTechnicalDocument(TechnicalDocument)
    case editedTechnicalDocument(TechnicalDocument)
    
    mutating func intentToChange(document: TechnicalDocument){
        self = .editingTechnicalDocument(document)
    }
}
