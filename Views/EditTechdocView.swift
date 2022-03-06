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
                        Text("Ajouter étape")
                    }).frame(width: 130, height:20)
                        .padding(3)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 5)
                        )
                }
                List{
                    ForEach($technicalDocumentVM.steps, id: \.id){$step in
                        VStack{
                            Spacer().frame(height:15)
                            
                            Text("Titre: ").bold().frame(alignment:.leading)
                            TextField("",text:$step.title).font(Font.body.bold())
                            
                            Divider()
                            LazyVGrid(columns: cols,alignment: .leading){
                                Text("Description: ")
                            }
                            TextEditor(text:$step.description)
                            Divider()
                            LazyVGrid(columns: cols,alignment: .leading){
                                Text("Ordre:")
                                TextField("Ordre: ",value: $step.rank,formatter:formatter)
                            }
                            Divider()
                            NavigationLink(destination: StepIngredientListView().onAppear(){
                                stepVM.setStep(step: step)
                            }, label:{
                                Text("Modifier")
                            }).frame(width: 90)
                                .padding(3)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.green, lineWidth: 5)
                                )
                                .padding(15)
                        }
                        .listRowSeparatorTint(Color.red)
                    }
                    .onDelete(perform:{ indexSet in
                        if let index = indexSet.first{
                            technicalDocumentVM.technicalDocumentState.intentToChange(deleting: technicalDocumentVM.steps[index])
                        }
                    })
                }.listStyle(PlainListStyle())
                    .frame(minHeight:200)
                if technicalDocumentVM.hideCosts {
                    VStack{
                        Text("Coûts de production").underline()
                        VStack(alignment:.leading){
                            Text("Coûts matières: \(technicalDocumentVM.calculateMatterCosts())€")
                            Text("Coûts assaisonnements: \(technicalDocumentVM.calculateSeasoningCosts())€")
                            Text("Coûts fluides: \(technicalDocumentVM.calculateFluidCosts(costs: costsVM.getCostsReference()))€")
                            Text("Coûts personnel: \(technicalDocumentVM.calculatePersonnelCosts(costs: costsVM.getCostsReference()))€")
                        }
                        Spacer().frame(height:10)
                        Text("Prix de vente").underline()
                        VStack(alignment:.leading){
                            Text("Prix de vente: \(technicalDocumentVM.calculateSalesPrice(costs: costsVM.getCostsReference(), byPortions: false))€")
                            Text("Prix de vente par portion: \(technicalDocumentVM.calculateSalesPrice(costs: costsVM.getCostsReference(), byPortions: true))€")
                            Text("Bénéfice par portion: \(technicalDocumentVM.calculateProfitByPortion(costs: costsVM.getCostsReference()))€")
                            Text("Seuil de rentabilité: \(technicalDocumentVM.rentabilityLimit(costs: costsVM.getCostsReference())) portions")
                        }
                    }
                }
                VStack(alignment:.leading){
                    Toggle("Montrer les coûts:", isOn:$technicalDocumentVM.hideCosts)
                    Toggle("Utiliser paramètres du système:", isOn:$technicalDocumentVM.byDefault)
                    Toggle("Utiliser charges:", isOn:$technicalDocumentVM.usesCharges).disabled(!technicalDocumentVM.byDefault)
                }
            }
            HStack{
                Button("Enregistrer"){
                    technicalDocumentVM.technicalDocumentState.intentToChange(document: TechnicalDocument(id: technicalDocumentVM.id, name: technicalDocumentVM.name, header: technicalDocumentVM.header, author: technicalDocumentVM.author, respo: technicalDocumentVM.responsable, cat: technicalDocumentVM.category, nbServed: technicalDocumentVM.nbServed, def: technicalDocumentVM.byDefault, charges: technicalDocumentVM.usesCharges, ass: technicalDocumentVM.assaisonnemments, steps: technicalDocumentVM.steps))
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
            newValue in changeValue(newValue)
        })
        .onChange(of: stepVM.stepState, perform: {
            newValue in changeValue(newValue)
        })
        .navigationTitle(technicalDocumentVM.name)
    }
    
    private func changeValue(_ newValue: TechnicalDocumentIntent){
        switch newValue{
        case .editedTechnicalDocument(_), .cancelledTechnicalDocumentModifications, .addedStepToDocument(_), .deletedStepFromDocument(_):
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
