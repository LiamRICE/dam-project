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
    @EnvironmentObject var costsVM: CostsVM
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            List{
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
                            NavigationLink(destination: StepIngredientListView().onAppear(){
                                stepVM.setStep(step: step)
                            }, label:{
                                Text("Ingredients")
                            })
                        }
                    }
                }.frame(minHeight:200)
                if technicalDocumentVM.hideCosts {
                    VStack{
                        Text("Coûts de production")
                        VStack(alignment:.leading){
                            Text("Coûts matières: \(technicalDocumentVM.calculateMatterCosts())€")
                            Text("Coûts assaisonnements: \(technicalDocumentVM.calculateSeasoningCosts())€")
                            Text("Coûts fluides: \(technicalDocumentVM.calculateFluidCosts(costs: costsVM.getCostsReference()))€")
                            Text("Coûts personnel: \(technicalDocumentVM.calculatePersonnelCosts(costs: costsVM.getCostsReference()))€")
                        }
                        Text("Prix de vente")
                        VStack(alignment:.leading){
                            Text("Prix de vente: \(technicalDocumentVM.calculateSalesPrice(costs: costsVM.getCostsReference(), byPortions: false))€")
                            Text("Prix de vente par portion: \(technicalDocumentVM.calculateSalesPrice(costs: costsVM.getCostsReference(), byPortions: true))€")
                            Text("Bénéfice par portion: \(technicalDocumentVM.calculateProfitByPortion(costs: costsVM.getCostsReference()))€")
                            Text("Seuil de rentabilité: \(technicalDocumentVM.rentabilityLimit(costs: costsVM.getCostsReference())) portions")
                        }
                    }
                }
                VStack(alignment:.leading){
                    Toggle("Montrer:", isOn:$technicalDocumentVM.hideCosts)
                    Toggle("Utiliser paramètres du système:", isOn:$technicalDocumentVM.byDefault)
                    Toggle("Utiliser charges:", isOn:$technicalDocumentVM.usesCharges).disabled(!technicalDocumentVM.byDefault)
                }
            }
            HStack{
                Button("Modifier"){
                    technicalDocumentVM.technicalDocumentState.intentToChange(document: TechnicalDocument(id: technicalDocumentVM.id, name: technicalDocumentVM.name, header: technicalDocumentVM.header, author: technicalDocumentVM.author, respo: technicalDocumentVM.responsable, cat: technicalDocumentVM.category, nbServed: technicalDocumentVM.nbServed, def: technicalDocumentVM.byDefault, charges: technicalDocumentVM.usesCharges, ass: technicalDocumentVM.assaisonnemments, steps: technicalDocumentVM.steps))
                }
                Button("Annuler"){
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
        .navigationTitle(technicalDocumentVM.name)
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
