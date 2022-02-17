//
//  ContentView.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var ingredientListVM: IngredientListVM
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: IngredientListView().task {
                    print("loading data...")
                    ingredientListVM.loadModel()
                }){
                    Text("Ingredients")
                }
            }
        }.navigationTitle("Menu")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
