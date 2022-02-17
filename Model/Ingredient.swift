//
//  Ingredient.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public class Ingredient: Equatable{
    public static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.code == rhs.code
    }
    
    var code: Int
    var libelle: String
    var unit: String
    var unitPrice: Double
    var stocks: Double
    var stockValue: Double
    var allergen: Bool
    
    init(code: Int, libelle: String, unit: String, unitprice: Double, stocks: Double, stockvalue: Double, allergene: Bool){
        self.code = code
        self.libelle = libelle
        self.unit = unit
        self.unitPrice = unitprice
        self.stocks = stocks
        self.stockValue = stockvalue
        self.allergen = allergene
    }
    
    init(){
        self.code = 0
        self.libelle = "libelle"
        self.unit = "unite"
        self.unitPrice = 0
        self.stocks = 0
        self.stockValue = 0
        self.allergen = false
    }
}
