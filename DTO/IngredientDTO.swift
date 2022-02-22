//
//  Ingredient.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public class IngredientDTO: Decodable, Encodable{
    var code: Int
    var libelle: String
    var unit: String
    var unitprice: Double
    var stocks: Double
    var stockvalue: Double
    var allergene: Int
    
    init(code: Int, libelle: String, unit: String, unitprice: Double, stocks: Double, stockvalue: Double, allergene: Int){
        self.code = code
        self.libelle = libelle
        self.unit = unit
        self.unitprice = unitprice
        self.stocks = stocks
        self.stockvalue = stockvalue
        self.allergene = allergene
    }
    
    public static func translate(ingredientdto: IngredientDTO) -> Ingredient{
        return Ingredient(code: ingredientdto.code, libelle: ingredientdto.libelle, unit: ingredientdto.unit, unitprice: ingredientdto.unitprice, stocks: ingredientdto.stocks, stockvalue: ingredientdto.stockvalue, allergene: ingredientdto.allergene==1)
    }
    
    public static func translate(ingredient: Ingredient) -> IngredientDTO{
        return IngredientDTO(code: ingredient.code, libelle: ingredient.libelle, unit: ingredient.unit, unitprice: ingredient.unitPrice, stocks: ingredient.stocks, stockvalue: ingredient.stockValue, allergene: ingredient.allergen ? 1 : 0)
    }
}
