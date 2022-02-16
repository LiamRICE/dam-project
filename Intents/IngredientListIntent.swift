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
    
    mutating func intentToChange(){
        self = .changingIngredientList
        print("List State : changingIngredientList")
    }
}
