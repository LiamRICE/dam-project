//
//  StepIntent.swift
//  dam-project
//
//  Created by m1 on 23/02/2022.
//

import Foundation

public enum StepIntent: Equatable{
    case ready
    case modifyingIngredients([StepIngredient])
    case modifiedIngredients([StepIngredient])
    
    mutating func intentToChange(ingredients: [StepIngredient]){
        self = .modifyingIngredients(ingredients)
    }
}
