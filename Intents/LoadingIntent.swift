//
//  LoadingIntent.swift
//  dam-project
//
//  Created by m1 on 17/02/2022.
//

import Foundation

public enum LoadingIntent: Equatable{
    case ready
    case loadingIngredients
    case loadedIngredients
    case loadingDocuments
    case loadedDocuments
    
    mutating func intentToChange(ingredients: Bool){
        self = .loadingIngredients
    }
    
    mutating func intentToChange(documents: Bool){
        self = .loadingDocuments
    }
}
