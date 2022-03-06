//
//  TicketIntent.swift
//  dam-project
//
//  Created by m1 on 05/03/2022.
//

import Foundation

public enum TicketIntent: Equatable{
    case ready
    case addingTicketToList(Ticket)
    case addedTicketToList(Ticket)
    case removingTicketFromList(Ticket)
    case removedTicketFromList(Ticket)
    case commitingTickets([Ticket], Bool)
    case commitedTickets([Ticket], Bool)
    case resetingTicketList
    case resetTicketList
    
    mutating func intentToChange(adding: Ticket){
        self = .addingTicketToList(adding)
    }
    
    mutating func intentToChange(removing: Ticket){
        self = .removingTicketFromList(removing)
    }
    
    mutating func intentToChange(reset: Bool){
        self = .resetingTicketList
    }
    
    mutating func intentToChange(commit: [Ticket], isDecremented: Bool){
        self = .commitingTickets(commit, isDecremented)
    }
}
