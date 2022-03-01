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
    case addingTechnicalDocument(TechnicalDocument)
    case addedTechnicalDocument(TechnicalDocument)
    case addingStepToDocument(Step)
    case addedStepToDocument(Step)
    
    mutating func intentToChange(document: TechnicalDocument){
        self = .editingTechnicalDocument(document)
    }
    
    mutating func intentToChange(cancel: Bool){
        self = .cancellingTechnicalDocumentModifications
    }
    
    mutating func intentToChange(adding: TechnicalDocument){
        self = .addingTechnicalDocument(adding)
    }
    
    mutating func intentToChange(adding: Step){
        self = .addingStepToDocument(adding)
    }
}
