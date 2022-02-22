//
//  Ingredient.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public class StepIngredient{
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
}
