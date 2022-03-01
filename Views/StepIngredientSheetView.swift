//
//  StepIngredientSheetView.swift
//  dam-project
//
//  Created by Liam RICE on 23/02/2022.
//

import SwiftUI

struct StepIngredientSheetView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var technicalDocumentVM: TechnicalDocumentVM
    @EnvironmentObject var stepVM: StepVM
    
    var body: some View {
        VStack{
            Text(stepVM.title)
            NavigationLink(destination: AddIngredientToStepView(), label: {
                Text("Ajouter un ingrédient")
            })
            ForEach($stepVM.ingredients, id: \.code){$ingredient in
                LazyVGrid(columns: cols,alignment: .leading){
                    Text("Nom: ")
                    Text(ingredient.libelle)
                    Text("Quantité: ")
                    LazyVGrid(columns: cols,alignment: .leading){
                        TextField("",value: $ingredient.quantity,formatter:formatter)
                        TextField("",text: $ingredient.unit)
                    }
                }
            }
            HStack{
                Button("Enregistrer"){
                    for i in stepVM.ingredients{
                        print("\(i.libelle) : \(i.quantity)")
                    }
                    stepVM.stepState.intentToChange(ingredients: stepVM.ingredients)
                }
                Button("Annuler"){
                    dismiss()
                }
            }
        }
        .onChange(of: stepVM.stepState, perform: {
            newValue in valueChanged(newValue)
        })
    }
    
    private func valueChanged(_ newValue: StepIntent){
        switch newValue{
        case .addedIngredient(_), .modifiedIngredients(_):
            stepVM.stepState = .ready
        default:
            return
        }
    }
}
/*
struct StepIngredientSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StepIngredientSheetView()
    }
}
*/
