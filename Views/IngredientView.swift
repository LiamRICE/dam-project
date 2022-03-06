//
//  IngredientView.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct IngredientView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    var cols2 = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @EnvironmentObject var ingredientListVM: IngredientListVM
    @EnvironmentObject var ingredientVM: IngredientVM
    @Environment(\.presentationMode) var presentationMode
    @State var showingDeleteConfirm: Bool = false
    
    var body: some View {
        VStack{
            LazyVGrid(columns:cols, alignment:.leading, spacing: 20){
                Text("Code:")
                Text(String(ingredientVM.code)).padding(.leading,20)
                Text("Libelle:")
                TextField("", text: $ingredientVM.libelle).padding(.leading,20)
                Text("Unité:")
                TextField("", text: $ingredientVM.unit).padding(.leading,20)
                Text("Prix unitaire:")
                TextField("", value: $ingredientVM.unitPrice,formatter:formatter).padding(.leading,20)
                Text("Stocks:")
                TextField("", value: $ingredientVM.stocks,formatter:formatter).padding(.leading,20)
            }.padding(.horizontal,20)
                .padding(.bottom, 10)
            LazyVGrid(columns:cols, alignment:.leading, spacing: 20){
                Text("Valeur du stock:")
                Text(String(ingredientVM.stocks * ingredientVM.unitPrice)).padding(.leading,20)
                Text("Allergène:")
                Toggle("", isOn: $ingredientVM.allergen).padding(.trailing,120)
            }.padding(.horizontal,20)
            HStack{
                LazyVGrid(columns:cols2, alignment:.center){
                Button("Enregistrer"){
                    ingredientVM.ingredientState.intentToChange(modifying: Ingredient(code: ingredientVM.code, libelle: ingredientVM.libelle, unit: ingredientVM.unit, unitprice: ingredientVM.unitPrice, stocks: ingredientVM.stocks, stockvalue: ingredientVM.stockValue, allergene: ingredientVM.allergen))
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
                    ingredientVM.ingredientState.intentToChange(cancel: true)
                }.frame(width: 90)
                    .padding(3)
                    .foregroundColor(Color.white)
                    .background(Color.pink)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.pink, lineWidth: 5)
                    )
                    .padding(15)
                Button("Supprimer"){
                    showingDeleteConfirm.toggle()
                }.frame(width: 90)
                    .padding(3)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 5)
                    )
                    .padding(15)
                .alert("Êtes-vous sûr de supprimer cet ingrédient?", isPresented: $showingDeleteConfirm){
                    Button("Oui", role: .destructive){
                        ingredientListVM.ingredientListState.intentToChange(delete: self.ingredientVM.getIngredientReference())
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Button("Non", role: .cancel){
                        // does nothing
                    }
                }
                }
            }.navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: self.ingredientVM.ingredientState, perform: {
            newValue in valueChanged(newValue)
        })
        .navigationTitle(ingredientVM.libelle)
    }
    
    private func valueChanged(_ newValue: IngredientIntent){
        switch self.ingredientVM.ingredientState{
        case .modifiedIngredient(_):
            self.ingredientVM.ingredientState = .ready
            self.ingredientListVM.ingredientListState = .changedIngredientList
        case .cancelledModifications:
            self.ingredientVM.ingredientState = .ready
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

