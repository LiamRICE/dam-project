//
//  EditTechdocView.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct EditTechdocView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @EnvironmentObject var technicalDocumentVM: TechnicalDocumentVM
    @EnvironmentObject var stepVM: StepVM
    @EnvironmentObject var stepIngredientVM: StepIngredientVM
    
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
                }
            }
            // Steps
            LazyVGrid(columns: cols, alignment: .leading){
                Text("Etapes")
                NavigationLink(destination: AddStepToTechdocView().onAppear(perform: {
                    stepVM.setStep(step: Step())
                }), label: {
                    Text("Ajouter une étape")
                })
            }
            List{
                ForEach($technicalDocumentVM.steps, id: \.id){$step in
                    VStack{
                        LazyVGrid(columns: cols,alignment: .leading){
                            Text("Titre: ")
                            TextField("",text:$step.title)
                            Text("Description: ")
                            TextField("",text:$step.description)
                            Text("Ordre:")
                            TextField("Ordre: ",value: $step.rank,formatter:formatter)
                        }
                        NavigationLink(destination: StepIngredientSheetView().onAppear(){
                            stepVM.setStep(step: step)
                        }, label:{
                            Text("Ingredients")
                        })
                    }
                }
            }
            // Footer
            LazyVGrid(columns:cols, alignment:.leading){
                Text("Cacher les couts:")
                Text("PLACEHOLDER")
                Text("Utiliser paramètres du système:")
                Text("PLACEHOLDER")
                Text("Utiliser charges:")
                Text("PLACEHOLDER")
            }
            HStack{
                Button("Modifier"){
                    // TODO - confirm modifications
                    technicalDocumentVM.technicalDocumentState.intentToChange(document: TechnicalDocument(id: technicalDocumentVM.id, name: technicalDocumentVM.name, header: technicalDocumentVM.header, author: technicalDocumentVM.author, respo: technicalDocumentVM.responsable, cat: technicalDocumentVM.category, nbServed: technicalDocumentVM.nbServed, def: technicalDocumentVM.byDefault, charges: technicalDocumentVM.usesCharges, ass: technicalDocumentVM.assaisonnemments, steps: technicalDocumentVM.steps))
                }
                Button("Annuler"){
                    // TODO - reset modifications
                    technicalDocumentVM.technicalDocumentState.intentToChange(cancel: true)
                }
            }
        }
        .onChange(of: technicalDocumentVM.technicalDocumentState, perform: {
            newValue in changeValue(newValue)
        })
        .onChange(of: stepVM.stepState, perform: {
            newValue in changeValue(newValue)
        })
    }
    
    private func changeValue(_ newValue: TechnicalDocumentIntent){
        switch newValue{
        case .editedTechnicalDocument(_), .cancelledTechnicalDocumentModifications, .addedStepToDocument(_):
            technicalDocumentVM.technicalDocumentState = .ready
        default:
            return
        }
    }
    
    private func changeValue(_ newValue: StepIntent){
        switch newValue{
        case .addedStep(_):
            stepVM.stepState = .ready
        default:
            return
        }
    }
}

struct EditTechdocView_Previews: PreviewProvider {
    static var previews: some View {
        EditTechdocView()
    }
}
