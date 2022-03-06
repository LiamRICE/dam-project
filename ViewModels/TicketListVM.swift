//
//  TicketListVM.swift
//  dam-project
//
//  Created by m1 on 05/03/2022.
//

import Foundation

public class TicketListVM: ObservableObject{
    private var model: [Ticket]
    @Published var ticketList: [Ticket]
    @Published var receiptList: [Ticket]
    @Published var ticketState: TicketIntent = .ready{
        didSet{
            switch ticketState{
            case .commitingTickets(let tickets, let decrement):
                self.ticketState = .commitedTickets(tickets, decrement)
            case .resetingTicketList:
                self.receiptList = []
                self.ticketState = .resetTicketList
            case .removingTicketFromList(let ticket):
                if let index = self.receiptList.firstIndex(of: ticket){
                    self.receiptList.remove(at: index)
                }
            case .addingTicketToList(let ticket):
                self.receiptList.append(ticket)
                self.ticketState = .addedTicketToList(ticket)
            default:
                return
            }
        }
    }
    
    init(){
        self.model = []
        self.receiptList = []
        self.ticketList = []
    }
    
    public func loadModel() async {
        self.ticketList = await DataDAO.getTickets()
        self.model = self.ticketList
    }
}
