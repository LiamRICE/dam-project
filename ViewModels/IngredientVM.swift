//
//  IngredientVM.swift
//  dam-project
//
//  Created by m1 on 17/02/2022.
//

import Foundation

public class IngredientVM: ObservableObject{
    private var model: Ingredient
    @Published var code: Int
    @Published var libelle: String
    @Published var unit: String
    @Published var unitPrice: Double
    @Published var stocks: Double
    @Published var stockValue: Double
    @Published var allergen: Bool
    @Published var ingredientState: IngredientIntent = .ready{
        didSet{
            switch ingredientState{
            case .modifyingIngredient(let ingredient):
                self.model.code = ingredient.code
                self.model.libelle = ingredient.libelle
                self.model.unit = ingredient.unit
                self.model.unitPrice = ingredient.unitPrice
                self.model.stocks = ingredient.stocks
                self.model.stockValue = ingredient.stockValue
                self.model.allergen = ingredient.allergen
                print("IngredientState : modifiedIngredient")
                Task{await DataDAO.putIngredient(ingredient: ingredient)}
                self.ingredientState = .modifiedIngredient(ingredient)
            case .cancellingModifications:
                self.code = self.model.code
                self.libelle = self.model.libelle
                self.unit = self.model.unit
                self.unitPrice = self.model.unitPrice
                self.stocks = self.model.stocks
                self.stockValue = self.model.stockValue
                self.allergen = self.model.allergen
                self.ingredientState = .cancelledModifications
            default:
                return
            }
        }
    }
    
    init(){
        self.model = Ingredient()
        self.code = model.code
        self.libelle = model.libelle
        self.unit = model.unit
        self.unitPrice = model.unitPrice
        self.stocks = model.stocks
        self.stockValue = model.stockValue
        self.allergen = model.allergen
    }
    
    public func setIngredient(ingredient: Ingredient){
        self.model = ingredient
        self.code = model.code
        self.libelle = model.libelle
        self.unit = model.unit
        self.unitPrice = model.unitPrice
        self.stocks = model.stocks
        self.stockValue = model.stockValue
        self.allergen = model.allergen
    }
    
    public func getIngredientReference() -> Ingredient{
        return self.model
    }
}
