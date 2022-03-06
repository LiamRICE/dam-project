//
//  IngredientListView.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import SwiftUI

struct IngredientListView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var ingredientListVM : IngredientListVM
    @EnvironmentObject var ingredientVM: IngredientVM
    
    private func stateChanged(_ newValue: IngredientListIntent){
        switch newValue {
        case .changedIngredientList, .searchedIngredientList(_):
            ingredientListVM.ingredientListState = .ready
            print("List State : ready")
        default:
            return
        }
    }
    
    var body: some View {
        VStack{
            NavigationLink(destination: AddIngredientView()){
                Text("Ajouter un ingrédient")
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 5)
                    )
            }.padding(5)
            LazyVGrid(columns:cols, alignment:.leading){
                Picker("Catégorie", selection: $ingredientListVM.category){
                    Text("Tous").tag(-1)
                    Text("Viandes / Volailles").tag(0)
                    Text("Poisson et Crustacés").tag(1)
                    Text("Crèmerie").tag(2)
                    Text("Fruits et Légumes").tag(3)
                    Text("Epicerie").tag(4)
                }
                TextField("search", text: $ingredientListVM.regex)
            }.padding(.horizontal,20)
            Button("Rechercher"){
                let searchObject = IngredientListSearch()
                searchObject.setCategory(cat: ingredientListVM.category)
                searchObject.setSearch(search: ingredientListVM.regex)
                ingredientListVM.ingredientListState.intentToChange(search: searchObject)
            }.padding(7).foregroundColor(Color.white).overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 5)
            ).background(Color.blue)
            List{
                ForEach(ingredientListVM.ingredientList, id: \.code){
                    ingredient in NavigationLink(destination: IngredientView().onAppear(perform: {
                        ingredientVM.setIngredient(ingredient: ingredient)
                    })){
                        Text("\(ingredient.code) - \(ingredient.libelle)")
                    }
                }
            }.listStyle(PlainListStyle())
        }
        .onChange(of: ingredientListVM.ingredientListState, perform: {
            newValue in stateChanged(newValue)
        })
        .navigationTitle("Mercuriale")
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListView()
    }
}

