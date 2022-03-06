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
    @Environment(\.presentationMode) var presentationMode
    
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
                Text(String(ingredientVM.stocks * ingredientVM.unitPrice))
                Text("Allergène:")
                Toggle("Allergène:", isOn: $ingredientVM.allergen)
            }
            HStack{
                Button("Ajouter"){
                    ingredientListVM.ingredientListState.intentToChange(adding: Ingredient(code: ingredientVM.code, libelle: ingredientVM.libelle, unit: ingredientVM.unit, unitprice: ingredientVM.unitPrice, stocks: ingredientVM.stocks, stockvalue: ingredientVM.stockValue, allergene: ingredientVM.allergen))
                    self.presentationMode.wrappedValue.dismiss()
                }.frame(width: 90)
                    .padding(3)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 5)
                    )
                    .padding(15)
                Button("Annuler"){
                    self.presentationMode.wrappedValue.dismiss()
                }.frame(width: 90)
                    .padding(3)
                    .foregroundColor(Color.white)
                    .background(Color.pink)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.pink, lineWidth: 5)
                    )
                    .padding(15)
            }
        }
        .onChange(of: self.ingredientListVM.ingredientListState, perform: {
            newValue in valueChanged(newValue)
        })
        .navigationTitle("Ajouter un ingrédient")
        .padding()
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

