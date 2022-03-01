//
//  StepIngredientVM.swift
//  dam-project
//
//  Created by m1 on 28/02/2022.
//

import Foundation

public class StepIngredientVM: ObservableObject{
    private var model: StepIngredient
    @Published var code: Int
    @Published var libelle: String
    @Published var quantity: Double
    @Published var unit: String
    @Published var unitprice: Double
    @Published var allergene: Bool
    @Published var stepIngredientState: IngredientInStepIntent = .ready{
        didSet{
            switch self.stepIngredientState{
            case .addingIngredientToStep(let step):
                self.model = step
                self.stepIngredientState = .addedIngredientToStep(step)
            default:
                return
            }
        }
    }
    
    init(){
        self.model = StepIngredient()
        self.code = model.code
        self.libelle = model.libelle
        self.quantity = model.quantity
        self.unit = model.unit
        self.unitprice = model.unitprice
        self.allergene = model.allergene
    }
}
