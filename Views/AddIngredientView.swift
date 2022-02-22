//
//  IngredientView.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct AddIngredientView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @EnvironmentObject var ingredientListVM: IngredientListVM
    @EnvironmentObject var ingredientVM: IngredientVM
    
    var body: some View {
        VStack{
            LazyVGrid(columns:cols, alignment:.leading){
                Text("Code:")
                TextField("", value: $ingredientVM.code, formatter: formatter)
                Text("Libelle:")
                TextField("", text: $ingredientVM.libelle)
                Text("Unité:")
                TextField("", text: $ingredientVM.unit)
                Text("Prix unitaire:")
                TextField("00.0", value: $ingredientVM.unitPrice, formatter: formatter)
                Text("Stocks:")
                TextField("", value: $ingredientVM.stocks, formatter: formatter)
            }
            LazyVGrid(columns:cols, alignment:.leading){
                Text("Valeur du stock:")
                Text(String(ingredientVM.stockValue))
                Text("Allergène:")
                Toggle("Allergène:", isOn: $ingredientVM.allergen)
            }
            HStack{
                Button("Ajouter"){
                    ingredientListVM.ingredientListState.intentToChange(adding: Ingredient(code: ingredientVM.code, libelle: ingredientVM.libelle, unit: ingredientVM.unit, unitprice: ingredientVM.unitPrice, stocks: ingredientVM.stocks, stockvalue: ingredientVM.stockValue, allergene: ingredientVM.allergen))
                }
            }
        }
        .onChange(of: self.ingredientListVM.ingredientListState, perform: {
            newValue in valueChanged(newValue)
        })
    }
    
    private func valueChanged(_ newValue: IngredientListIntent){
        switch self.ingredientListVM.ingredientListState{
        case .addedIngredient(_):
            print("IngredientState : ready")
            self.ingredientVM.ingredientState = .ready
            self.ingredientListVM.ingredientListState = .changedIngredientList
        default:
            return
        }
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}

