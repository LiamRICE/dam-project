//
//  Ingredient.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public class StepIngredient: Equatable{
    public static func == (lhs: StepIngredient, rhs: StepIngredient) -> Bool {
        return lhs.code == rhs.code
    }
    
    var code: Int
    var libelle: String
    var quantity: Double
    var unit: String
    var unitprice: Double
    var allergene: Bool
    
    init(code: Int, libelle: String, quantity: Double, unit: String, unitprice: Double, allergene: Bool){
        self.code = code
        self.libelle = libelle
        self.quantity = quantity
        self.unit = unit
        self.unitprice = unitprice
        self.allergene = allergene
    }
    
    init(){
        self.code = 0
        self.libelle = "libellé"
        self.quantity = 0
        self.unit = "unité"
        self.unitprice = 0
        self.allergene = false
    }
    
    public func isEqual(_ other: StepIngredient) -> Bool{
        return self.code == other.code && self.libelle == other.libelle && self.quantity == other.quantity && self.unit == other.unit && self.unitprice == other.unitprice && self.allergene == other.allergene
    }
}
