//
//  StepVM.swift
//  dam-project
//
//  Created by m1 on 23/02/2022.
//

import Foundation

public class StepVM: ObservableObject{
    private var model: Step
    @Published var id: Int
    @Published var title: String
    @Published var description: String
    @Published var time: Int
    @Published var rank: Int
    @Published var ingredients: [StepIngredient]
    @Published var showingSheet: Bool
    @Published var stepState: StepIntent = .ready{
        didSet{
            switch self.stepState{
            case .modifyingIngredients(let ingreds):
                Task{
                    for i in self.ingredients{
                        await DataDAO.putTechnicalDocIngredientInStep(step: self.model, ingredient: i)
                    }
                }
                model.ingredients = self.ingredients
                self.stepState = .modifiedIngredients(ingreds)
            case .addingStep(let step):
                self.model = step
                self.stepState = .addedStep(step)
            case .addingIngredient(let stepIngredient):
                var isUsed = false
                for i in model.ingredients{
                    if i.code == stepIngredient.code{
                        isUsed = true
                    }
                }
                if(!isUsed){
                    Task{
                        await DataDAO.postTechnicalDocIngredientInStep(step: self.model, ingredient: stepIngredient)
                    }
                    self.ingredients.append(stepIngredient)
                    self.model.ingredients = self.ingredients
                    self.stepState = .addedIngredient(stepIngredient)
                }
                else{
                    self.stepState = .addIngredientError(.duplicateError)
                }
            default:
                return
            }
        }
    }
    
    init(){
        self.model = Step()
        self.id = model.id
        self.title = model.title
        self.description = model.description
        self.time = model.time
        self.rank = model.rank
        self.ingredients = model.ingredients
        self.showingSheet = false
    }
    
    public func setStep(step: Step){
        self.model = step
        self.id = model.id
        self.title = model.title
        self.description = model.description
        self.time = model.time
        self.rank = model.rank
        self.ingredients = model.ingredients
        self.ingredients = step.ingredients
    }
    
    public func stepIsEqual(_ other: Step) -> Bool{
        return self.model.id == other.id
    }
}
