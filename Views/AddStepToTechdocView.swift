//
//  AddStepToTechdocView.swift
//  dam-project
//
//  Created by m1 on 27/02/2022.
//

import SwiftUI

struct AddStepToTechdocView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @EnvironmentObject var technicalDocumentVM: TechnicalDocumentVM
    @EnvironmentObject var technicalDocumentListVM: TechnicalDocumentListVM
    @EnvironmentObject var stepVM: StepVM
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            LazyVGrid(columns: cols,alignment: .leading){
                Text("Titre: ")
                TextField("",text:$stepVM.title)
                Text("Description: ")
            }
            TextEditor(text:$stepVM.description).frame(height:100)
            LazyVGrid(columns: cols,alignment: .leading){
                Text("Durée: ")
                TextField("Durée: ",value: $stepVM.time, formatter: formatter)
                Text("Ordre: ")
                TextField("Ordre: ",value: $stepVM.rank, formatter: formatter)
            }
            HStack{
                Button("Ajouter"){
                    stepVM.id = technicalDocumentListVM.getUnusedStepId()
                    stepVM.stepState.intentToChange(adding: Step(id: technicalDocumentListVM.getUnusedStepId(), title: stepVM.title, desc: stepVM.description, time: stepVM.time, rk: stepVM.rank, ingredients: []))
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
                    // TODO - reset modifications
                    stepVM.stepState.intentToChange(cancel: true)
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
        .onChange(of: stepVM.stepState, perform: {
            newValue in valueChanged(newValue)
        })
        .navigationTitle("Ajouter une étape")
        .padding()
    }
    
    private func valueChanged(_ newValue: StepIntent){
        switch newValue{
        case .addedStep(let step):
            self.technicalDocumentVM.technicalDocumentState.intentToChange(adding: step)
            self.stepVM.stepState = .ready
        default:
            return
        }
    }
}

struct AddStepToTechdocView_Previews: PreviewProvider {
    static var previews: some View {
        AddStepToTechdocView()
    }
}
