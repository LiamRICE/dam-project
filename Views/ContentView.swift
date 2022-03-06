//
//  ContentView.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var ingredientListVM: IngredientListVM
    @EnvironmentObject var ticketListVM: TicketListVM
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: IngredientListView()){
                    Text("Mercuriale").font(.system(size:20))
                }.frame(width: 200, height: 30).padding().foregroundColor(Color.white).background(Color.blue).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.blue, lineWidth: 5)
                ).padding(5)
                NavigationLink(destination: AllergenListView()){
                    Text("Ingrédients Allergènes").font(.system(size:20))
                }.frame(width: 200, height: 30).padding().foregroundColor(Color.white).background(Color.pink).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.pink, lineWidth: 5)
                ).padding(5)
                NavigationLink(destination: TechdocListView()){
                    Text("Fiches Techniques").font(.system(size:20))
                }.frame(width: 200, height: 30).padding().foregroundColor(Color.white).background(Color.green).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.green, lineWidth: 5)
                ).padding(5)
                NavigationLink(destination: TicketListView()){
                    Text("Etiquettes").font(.system(size:20))
                }.task{
                    await ticketListVM.loadModel()
                }.frame(width: 200, height: 30).padding().foregroundColor(Color.white).background(Color.teal).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.teal, lineWidth: 5)
                ).padding(5)
                NavigationLink(destination: CostsView()){
                    Text("Paramètres").font(.system(size:20))
                }.frame(width: 200, height: 30).padding().foregroundColor(Color.white).background(Color.gray).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 5)
                ).padding(5)
            }.navigationBarTitle("Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
