//
//  IngredientInStepIntent.swift
//  dam-project
//
//  Created by m1 on 28/02/2022.
//

import Foundation

public enum IngredientInStepIntent: Equatable{
    case ready
    case addingIngredientToStep(StepIngredient)
    case addedIngredientToStep(StepIngredient)
    
    mutating func intentToChange(adding: StepIngredient){
        self = .addingIngredientToStep(adding)
    }
}
