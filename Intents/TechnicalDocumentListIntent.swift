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
    case addTechnicalDocumentError(AddTechnicalDocumentError)
    case searchingTechnicalDocumentList(TechnicalDocumentListSearch)
    case searchedTechnicalDocumentList(TechnicalDocumentListSearch)
    
    mutating func intentToChange(){
        self = .changingTechnicalDocumentList
    }
    
    mutating func intentToChange(adding: TechnicalDocument){
        self = .addingTechnicalDocument(adding)
    }
    
    mutating func intentToChange(search: TechnicalDocumentListSearch){
        self = .searchingTechnicalDocumentList(search)
    }
}
