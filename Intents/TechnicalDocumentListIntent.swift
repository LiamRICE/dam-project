//
//  TechnicalDocumentListIntent.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import Foundation

public enum TechnicalDocumentListIntent: Equatable{
    case ready
    case changingTechnicalDocumentList
    case changedTechnicalDocumentList
    case addingTechnicalDocument(TechnicalDocument)
    case addedTechnicalDocument(TechnicalDocument)
    
    mutating func intentToChange(){
        self = .changingTechnicalDocumentList
    }
    
    mutating func intentToChange(adding: TechnicalDocument){
        self = .addingTechnicalDocument(adding)
    }
}
