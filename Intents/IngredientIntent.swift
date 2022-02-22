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
    
    mutating func intentToChange(modifying: Ingredient){
        print("IngredientState : modifyingIngredient")
        self = .modifyingIngredient(modifying)
    }
}
