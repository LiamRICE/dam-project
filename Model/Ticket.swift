//
//  Ticket.swift
//  dam-project
//
//  Created by m1 on 04/03/2022.
//

import Foundation

public class Ticket: Equatable{
    
    var id: Int
    var name: String
    var ingredients: [TicketIngredient]
    
    init(id:Int, name: String, ingredients: [TicketIngredient]){
        self.id = id
        self.name = name
        self.ingredients = ingredients
    }
    
    public static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.id == rhs.id
    }
}
