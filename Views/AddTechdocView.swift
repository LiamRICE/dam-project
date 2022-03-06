//
//  AddTechdocView.swift
//  dam-project
//
//  Created by m1 on 27/02/2022.
//

import SwiftUI

struct AddTechdocView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @EnvironmentObject var technicalDocumentVM: TechnicalDocumentVM
    @EnvironmentObject var technicalDocumentListVM: TechnicalDocumentListVM
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            // Header
            LazyVGrid(columns: cols,alignment: .leading){
                Group{
                    Text("Intitulé: ")
                    TextField("Intitulé: ",text: $technicalDocumentVM.name)
                    Text("Responsable: ")
                    TextField("Responsable: ",text: $technicalDocumentVM.responsable)
                    Text("Nombre de Couverts: ")
                    TextField("Nombre de couverts: ",value: $technicalDocumentVM.nbServed,formatter:formatter)
                }
                Group{
                    Text("Description: ")
                    TextField("Description: ",text: $technicalDocumentVM.header)
                    Text("Auteur: ")
                    TextField("Auteur: ",text: $technicalDocumentVM.author)
                    Text("Catégorie: ")
                    TextField("Catégorie: ",text: $technicalDocumentVM.category)
                    Text("Assaisonnements: ")
                    TextField("Assaisonnements: ",value: $technicalDocumentVM.assaisonnemments,formatter:formatter)
                }
            }
            HStack{
                Button("Ajouter"){
                    technicalDocumentVM.id = technicalDocumentListVM.getUnusedId()
                    technicalDocumentVM.technicalDocumentState.intentToChange(adding: TechnicalDocument(id: technicalDocumentListVM.getUnusedId(), name: technicalDocumentVM.name, header: technicalDocumentVM.header, author: technicalDocumentVM.author, respo: technicalDocumentVM.responsable, cat: technicalDocumentVM.category, nbServed: technicalDocumentVM.nbServed, def: true, charges: false, ass: technicalDocumentVM.assaisonnemments, steps: []))
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
                    technicalDocumentVM.technicalDocumentState.intentToChange(cancel: true)
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
        .onChange(of: technicalDocumentVM.technicalDocumentState, perform: {
            newValue in valueChanged(newValue)
        })
        .onChange(of: technicalDocumentListVM.technicalDocumentListState, perform: {
            newValue in valueChanged(newValue)
        })
        .navigationTitle("Ajouter une fiche technique")
        .padding()
    }
    
    private func valueChanged(_ newValue: TechnicalDocumentIntent){
        switch newValue{
        case .addedTechnicalDocument(let doc):
            technicalDocumentVM.technicalDocumentState = .ready
            technicalDocumentListVM.technicalDocumentListState.intentToChange(adding: doc)
        default:
            return
        }
    }
    
    private func valueChanged(_ newValue: TechnicalDocumentListIntent){
        switch newValue{
        case .addTechnicalDocumentError(let error):
            // popup with error
            print(error.rawValue)
            technicalDocumentListVM.technicalDocumentListState = .ready
        default:
            return
        }
    }
}

struct AddTechdocView_Previews: PreviewProvider {
    static var previews: some View {
        AddTechdocView()
    }
}
