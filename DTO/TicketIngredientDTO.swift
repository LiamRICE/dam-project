//
//  TicketIngredientDTO.swift
//  dam-project
//
//  Created by m1 on 05/03/2022.
//

import Foundation

public class TicketIngredientDTO: Codable{
    var code: Int
    var libelle: String
    var stocks: Double
    var unitprice: Double
    var allergene: Int
    var quantite: Double
    
    init(code: Int, lib: String, stock: Double, unitprice: Double, allergen: Int, qtte: Double){
        self.code = code
        self.libelle = lib
        self.stocks = stock
        self.unitprice = unitprice
        self.allergene = allergen
        self.quantite = qtte
    }
    
    public static func translate(tidto: TicketIngredientDTO) -> TicketIngredient{
        return TicketIngredient(code: tidto.code, lib: tidto.libelle, stock: tidto.stocks, unitprice: tidto.unitprice, allergen: tidto.allergene == 1 ? true : false, qtte: tidto.quantite)
    }
}
