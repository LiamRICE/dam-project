//
//  StepIngredientSheetView.swift
//  dam-project
//
//  Created by Liam RICE on 23/02/2022.
//

import SwiftUI

struct StepIngredientListView: View {
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
            NavigationLink(destination: AddIngredientToStepView(), label: {
                Text("Ajouter un ingrédient")
            }).frame(width: 90)
                .padding(3)
                .foregroundColor(Color.white)
                .background(Color.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.green, lineWidth: 5)
                )
                .padding(15)
            List{
                ForEach($stepVM.ingredients, id: \.code){$ingredient in
                    LazyVGrid(columns: cols,alignment: .leading){
                        Text("Nom: ")
                        Text(ingredient.libelle)
                        Text("Quantité: ")
                        LazyVGrid(columns: cols,alignment: .leading){
                            TextField("",value: $ingredient.quantity,formatter:formatter)
                            Text(ingredient.unit)
                        }
                    }
                }
                .onDelete(perform:{ indexSet in
                    if let index = indexSet.first{
                        stepVM.stepState.intentToChange(deleting: stepVM.ingredients[index])
                    }
                })
            }.listStyle(PlainListStyle())
            HStack{
                Button("Enregistrer"){
                    for i in stepVM.ingredients{
                        print("\(i.libelle) : \(i.quantity)")
                    }
                    stepVM.stepState.intentToChange(ingredients: stepVM.ingredients)
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
                    dismiss()
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
        .onChange(of: stepVM.stepState, perform: {
            newValue in valueChanged(newValue)
        })
        .navigationTitle(stepVM.title)
    }
    
    private func valueChanged(_ newValue: StepIntent){
        switch newValue{
        case .addedIngredient(_), .modifiedIngredients(_), .deletedIngredient(_):
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
