//
//  IngredientView.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct IngredientView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var ingredientListVM: IngredientListVM
    @EnvironmentObject var ingredientVM: IngredientVM
    
    var body: some View {
        VStack{
            LazyVGrid(columns:cols, alignment:.leading){
                Text("Code:")
                Text(String(ingredientVM.code))
                Text("Libelle:")
                TextField("", text: $ingredientVM.libelle)
                Text("Unité:")
                TextField("", text: $ingredientVM.unit)
                Text("Prix unitaire:")
                Stepper("", value: $ingredientVM.unitPrice, in: 0...9999, step: 0.01)
                Text("Stocks:")
                Stepper("", value: $ingredientVM.stocks, in: 0...9999, step: 0.001)
            }
            LazyVGrid(columns:cols, alignment:.leading){
                Text("Valeur du stock:")
                Text(String(ingredientVM.stockValue))
                Text("Allergène:")
                Toggle("Allergène:", isOn: $ingredientVM.allergen)
            }
            HStack{
                Button("Enregistrer"){
                    self.ingredientVM.ingredientState.intentToChange(modifying: Ingredient(code: ingredientVM.code, libelle: ingredientVM.libelle, unit: ingredientVM.unit, unitprice: ingredientVM.unitPrice, stocks: ingredientVM.stocks, stockvalue: ingredientVM.stockValue, allergene: ingredientVM.allergen))
                }
            }
        }
        .onChange(of: self.ingredientVM.ingredientState, perform: {
            newValue in valueChanged(newValue)
        })
    }
    
    private func valueChanged(_ newValue: IngredientIntent){
        switch self.ingredientVM.ingredientState{
        case .modifiedIngredient(_):
            print("IngredientState : ready")
            self.ingredientVM.ingredientState = .ready
            self.ingredientListVM.ingredientListState = .changedIngredientList
        default:
            return
        }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}

