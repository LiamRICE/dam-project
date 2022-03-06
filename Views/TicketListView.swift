//
//  TicketListView.swift
//  dam-project
//
//  Created by m1 on 04/03/2022.
//

import SwiftUI

struct TicketListView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var ticketListVM: TicketListVM
    
    var body: some View {
        VStack{
            Text("Fiches Techniques à ajouter").bold()
            List{
                ForEach(ticketListVM.ticketList, id: \.id){ticket in
                    VStack{
                        LazyVGrid(columns:cols, alignment:.leading){
                            Text("Intitulé: ").bold()
                            Text(ticket.name);
                        }
                        Button("Ajouter"){
                            ticketListVM.ticketState.intentToChange(adding: ticket)
                        }.foregroundColor(Color.blue)
                    }.padding()
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.green, lineWidth: 2)
                    )
                        .padding()
                }
            }.listStyle(PlainListStyle())
            Text("Ticket").bold()
            List{
                ForEach(ticketListVM.receiptList, id: \.id){ticket in
                    VStack{
                        LazyVGrid(columns:cols, alignment:.leading){
                            Text("Intitulé: ").bold()
                            Text(ticket.name)
                        }
                        Button("Enlever"){
                            ticketListVM.ticketState.intentToChange(removing: ticket)
                        }.foregroundColor(Color.blue)
                    }.padding()
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.red, lineWidth: 2)
                    )
                        .padding()
                }
            }.listStyle(PlainListStyle())
            LazyVGrid(columns:cols, alignment:.center){
                NavigationLink(destination: TicketView()){
                    Text("Confirmer")
                }.frame(width: 100)
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 5)
                    )
                    .padding(15)
                Button("Vider"){
                    ticketListVM.ticketState.intentToChange(reset: true)
                }.frame(width: 100)
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 5)
                    )
                    .padding(15)
            }
        }.navigationBarTitle("Etiquettes")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: ticketListVM.ticketState, perform: {
            newValue in valueChanged(newValue)
        })
    }
    
    private func valueChanged(_ newValue: TicketIntent){
        switch newValue {
        case .addedTicketToList(_), .removedTicketFromList(_), .resetTicketList:
            ticketListVM.ticketState = .ready
        default:
            return
        }
    }
}

struct TicketListView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListView()
    }
}
