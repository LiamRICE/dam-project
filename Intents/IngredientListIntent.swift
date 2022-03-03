//
//  IngredientListIntent.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public enum IngredientListIntent: Equatable{
    case ready
    case changingIngredientList
    case changedIngredientList
    case addingIngredient(Ingredient)
    case addedIngredient(Ingredient)
    case searchingIngredientList(IngredientListSearch)
    case searchedIngredientList(IngredientListSearch)
    case deletingIngredient(Ingredient)
    case deletedIngredient(Ingredient)
    case deleteIngredientError
    
    mutating func intentToChange(){
        self = .changingIngredientList
        print("List State : changingIngredientList")
    }
    
    mutating func intentToChange(adding: Ingredient){
        self = .addingIngredient(adding)
    }
    
    mutating func intentToChange(search: IngredientListSearch){
        self = .searchingIngredientList(search)
    }
    
    mutating func intentToChange(delete: Ingredient){
        self = .deletingIngredient(delete)
    }
}
