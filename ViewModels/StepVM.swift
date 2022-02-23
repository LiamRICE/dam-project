//
//  StepVM.swift
//  dam-project
//
//  Created by m1 on 23/02/2022.
//

import Foundation

public class StepVM: ObservableObject{
    private var model: Step
    @Published var ingredients: [StepIngredient]
    @Published var showingSheet: Bool
    @Published var stepState: StepIntent = .ready{
        didSet{
            switch self.stepState{
            case .modifyingIngredients(let ingreds):
                Task{
                    for i in ingreds{
                        await DataDAO.putTechnicalDocIngredientInStep(step: self.model, ingredient: i)
                    }
                }
                model.ingredients = ingreds
                self.stepState = .modifiedIngredients(ingreds)
            default:
                return
            }
        }
    }
    
    init(){
        self.model = Step()
        self.ingredients = model.ingredients
        self.showingSheet = false
    }
    
    public func setStep(step: Step){
        self.model = step
        self.ingredients = step.ingredients
    }
    
    public func stepIsEqual(_ other: Step) -> Bool{
        return self.model.id == other.id
    }
}
