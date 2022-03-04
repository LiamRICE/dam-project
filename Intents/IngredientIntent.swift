//
//  IngredientIntent.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import Foundation

public enum IngredientIntent: Equatable{
    case ready
    case modifyingIngredient(Ingredient)
    case modifiedIngredient(Ingredient)
    case cancellingModifications
    case cancelledModifications
    
    mutating func intentToChange(modifying: Ingredient){
        self = .modifyingIngredient(modifying)
    }
    
    mutating func intentToChange(cancel: Bool){
        self = .cancellingModifications
    }
}
