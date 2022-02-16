//
//  IngredientListView.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import SwiftUI

struct IngredientListView: View {
    
    @EnvironmentObject var ingredientListVM : IngredientListVM
    
    private func stateChanged(_ newValue: IngredientListIntent){
        switch newValue {
        case .changedIngredientList:
            ingredientListVM.ingredientListState = .ready
            print("List State : ready")
        default:
            return
        }
    }
    
    private func searchList(search: String) -> [Ingredient]{
        return ingredientListVM.subset(searchValue: search)
    }
    
    var body: some View {
        VStack{
            Button("Add"){
                print(ingredientListVM.ingredientList.count)
                ingredientListVM.ingredientList.append(Ingredient(code: 7, libelle: "crap", unit: "metric crapton", unitprice: 1, stocks: 1, stockvalue: 1, allergene: 0))
                ingredientListVM.ingredientListState.intentToChange()
                print(ingredientListVM.ingredientList.count)
            }
            TextField("search", text: $ingredientListVM.search).onSubmit {
                ingredientListVM.ingredientList = searchList(search: ingredientListVM.search)
            }
            List{
                ForEach(ingredientListVM.ingredientList, id: \.code){
                    ingredient in NavigationLink(destination: IngredientView(ingredient: ingredient)){
                        Text("\(ingredient.code) - \(ingredient.libelle)")
                    }
                }
            }
        }.onChange(of: ingredientListVM.ingredientListState, perform: {
            newValue in stateChanged(newValue)
        })
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListView()
    }
}

