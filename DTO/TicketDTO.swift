//
//  Ticket.swift
//  dam-project
//
//  Created by m1 on 04/03/2022.
//

import Foundation

public class TicketDTO: Codable{
    
    var id: Int
    var name: String
    var ingredients: [TicketIngredientDTO]
    
    init(id:Int, name: String, ingredients: [TicketIngredientDTO]){
        self.id = id
        self.name = name
        self.ingredients = ingredients
    }
    
    public static func translate(ticketdto: TicketDTO) -> Ticket{
        var ingredients: [TicketIngredient] = []
        for ingredient in ticketdto.ingredients{
            ingredients.append(TicketIngredientDTO.translate(tidto: ingredient))
        }
        return Ticket(id: ticketdto.id, name: ticketdto.name, ingredients: ingredients)
    }
}
