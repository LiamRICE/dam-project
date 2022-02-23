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
    @ObservedObject var stepVM: StepVM
    
    var body: some View {
        VStack{
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
                    for s in technicalDocumentVM.steps{
                        if(stepVM.stepIsEqual(s)){
                            s.ingredients = stepVM.ingredients
                        }
                    }
                    stepVM.stepState.intentToChange(ingredients: stepVM.ingredients)
                    dismiss()
                }
                Button("Annuler"){
                    dismiss()
                }
            }
        }
    }
    
    init(sVM: StepVM){
        self.stepVM = sVM
    }
}
/*
struct StepIngredientSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StepIngredientSheetView()
    }
}
*/
