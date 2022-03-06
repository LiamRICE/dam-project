//
//  TicketView.swift
//  dam-project
//
//  Created by m1 on 04/03/2022.
//

import SwiftUI

struct TicketView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var ticketListVM: TicketListVM
    @EnvironmentObject var ingredientListVM: IngredientListVM
    @State var decrement: Bool = false
    @State var errorAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        // for tickets in ticket list
        VStack{
            Text("Etiquette").bold()
            List{
                ForEach(ticketListVM.receiptList, id: \.id){ticket in
                    HStack{
                        LazyVGrid(columns:cols, alignment:.leading){
                            Text("Intitulé: ").bold()
                            Text(ticket.name)
                        }
                    }
                    VStack(alignment: .leading){
                        LazyVGrid(columns:cols, alignment:.leading){
                            Text("Ingredients: ").bold()
                        }
                        ForEach(ticket.ingredients, id: \.code){ingredient in
                            VStack{
                                Text("\u{2022} "+ingredient.libelle)
                            }
                        }
                    }
                }
            }.listStyle(PlainListStyle())
                .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 5)
                ).padding(10)
            Toggle("Décrémenter les stocks:", isOn: $decrement)
            Button("Valider"){
                self.ticketListVM.ticketState.intentToChange(commit: ticketListVM.receiptList, isDecremented: decrement)
            }.frame(width: 100)
                .padding(5)
                .foregroundColor(Color.white)
                .background(Color.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.green, lineWidth: 5)
                )
                .padding(15)
        }
        .padding()
        .onChange(of: ticketListVM.ticketState, perform: {
            newValue in valueChanged(newValue)
        })
        .onChange(of: ingredientListVM.ingredientListState, perform: {
            newValue in valueChanged(newValue)
        })
        .alert("Pas assez de stocks pour effectuer cette opération", isPresented: $errorAlert){
            Button("OK"){
                self.presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Ajouter des stocks pour pouvoir effectuer cette opération")
        }
    }
    
    private func valueChanged(_ newValue: TicketIntent){
        switch newValue {
        case .commitedTickets(let tickets, let bool):
            if bool{
                ingredientListVM.ingredientListState.intentToChange(substract: tickets)
            }
            ticketListVM.ticketState.intentToChange(reset: true)
        default:
            return
        }
    }
    
    private func valueChanged(_ newValue: IngredientListIntent){
        switch newValue {
        case .substractedStocks(_):
            ingredientListVM.ingredientListState.intentToChange()
            self.presentationMode.wrappedValue.dismiss()
        case .substractStockError:
            self.errorAlert.toggle()
            ingredientListVM.ingredientListState = .ready
        default:
            return
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
