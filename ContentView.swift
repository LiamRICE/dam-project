//
//  ContentView.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: IngredientListView()){
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
