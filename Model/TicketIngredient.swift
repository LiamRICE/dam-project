//
//  TicketIngredientDTO.swift
//  dam-project
//
//  Created by m1 on 05/03/2022.
//

import Foundation

public class TicketIngredient: Equatable{
    var code: Int
    var libelle: String
    var stocks: Double
    var unitprice: Double
    var allergene: Bool
    var quantite: Double
    
    init(code: Int, lib: String, stock: Double, unitprice: Double, allergen: Bool, qtte: Double){
        self.code = code
        self.libelle = lib
        self.stocks = stock
        self.unitprice = unitprice
        self.allergene = allergen
        self.quantite = qtte
    }
    
    public static func == (lhs: TicketIngredient, rhs: TicketIngredient) -> Bool {
        return lhs.code == rhs.code
    }
}
