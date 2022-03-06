//
//  AddIngredientToStepView.swift
//  dam-project
//
//  Created by m1 on 27/02/2022.
//

import SwiftUI

struct AddIngredientToStepView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @EnvironmentObject var ingredientListVM: IngredientListVM
    @EnvironmentObject var stepVM: StepVM
    @EnvironmentObject var stepIngredientVM: StepIngredientVM
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            // TODO - Search things behaving weirdly? Kicks you out when you try to edit them. Don't understand.
            LazyVGrid(columns: cols,alignment: .leading){
                Text("Etape:")
                Text(stepVM.title)
                Text("Ingrédient:")
                Picker("Ingrédient", selection: $stepIngredientVM.code){
                    ForEach(ingredientListVM.ingredientList, id:\.code){ ingredient in
                        Text(ingredient.libelle).tag(ingredient.code)
                    }
                }
                Text("Quantité:")
                TextField("Quantité: ",value: $stepIngredientVM.quantity,formatter:formatter)
            }
            HStack{
                Button("Ajouter"){
                    var ingredient: Ingredient = Ingredient()
                    for i in ingredientListVM.ingredientList{
                        if i.code == stepIngredientVM.code{
                            ingredient = i
                        }
                    }
                    stepIngredientVM.stepIngredientState.intentToChange(adding: StepIngredient(code: ingredient.code, libelle: ingredient.libelle, quantity: stepIngredientVM.quantity, unit: ingredient.unit, unitprice: ingredient.unitPrice, allergene: ingredient.allergen))
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
        .onChange(of: stepIngredientVM.stepIngredientState, perform: {
            newValue in valueChanged(newValue)
        })
        .navigationTitle("Ajouter un ingrédient")
        .padding()
    }
    
    private func valueChanged(_ newValue: IngredientInStepIntent){
        switch newValue {
        case .addedIngredientToStep(let ingredient):
            stepVM.stepState.intentToChange(adding: ingredient)
            stepIngredientVM.stepIngredientState = .ready
        default:
            return
        }
    }
}

struct AddIngredientToStepView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientToStepView()
    }
}
