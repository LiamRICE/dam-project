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
    case cancellingTechnicalDocumentModifications
    case cancelledTechnicalDocumentModifications
    
    mutating func intentToChange(document: TechnicalDocument){
        self = .editingTechnicalDocument(document)
    }
    
    mutating func intentToChange(cancel: Bool){
        self = .cancellingTechnicalDocumentModifications
    }
}
