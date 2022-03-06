//
//  AllergenListView.swift
//  dam-project
//
//  Created by m1 on 05/03/2022.
//

import SwiftUI

struct AllergenListView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    
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
    
    var body: some View {
        VStack{
            List{
                ForEach(ingredientListVM.ingredientList, id: \.code){
                    ingredient in
                    if ingredient.allergen {Text("\(ingredient.code) - \(ingredient.libelle)")}
                }
            }
        }.padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.red, lineWidth: 5)
            )
            .padding()
        .onChange(of: ingredientListVM.ingredientListState, perform: {
            newValue in stateChanged(newValue)
        })
        .navigationTitle("Allergènes")
    }
}

struct AllergenListView_Previews: PreviewProvider {
    static var previews: some View {
        AllergenListView()
    }
}
