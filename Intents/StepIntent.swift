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
    case addingStep(Step)
    case addedStep(Step)
    case addStepError
    case addingIngredient(StepIngredient)
    case addedIngredient(StepIngredient)
    case addIngredientError(AddIngredientToStepError)
    case cancellingModifications
    case cancelledModifications
    case deletingIngredient(StepIngredient)
    case deletedIngredient(StepIngredient)
    
    mutating func intentToChange(ingredients: [StepIngredient]){
        self = .modifyingIngredients(ingredients)
    }
    
    mutating func intentToChange(adding: Step){
        self = .addingStep(adding)
    }
    
    mutating func intentToChange(cancel: Bool){
        self = .cancellingModifications
    }
    
    mutating func intentToChange(adding: StepIngredient){
        self = .addingIngredient(adding)
    }
    
    mutating func intentToChange(deleting: StepIngredient){
        self = .deletingIngredient(deleting)
    }
}
