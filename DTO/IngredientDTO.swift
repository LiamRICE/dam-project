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
}
