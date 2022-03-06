//
//  TechdocView.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct TechdocView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var technicalDocumentVM: TechnicalDocumentVM
    @EnvironmentObject var technicalDocumentListVM: TechnicalDocumentListVM
    @EnvironmentObject var costsVM: CostsVM
    @Environment(\.presentationMode) var presentationMode
    @State var showingDeleteConfirm: Bool = false
    
    var body: some View {
        VStack{
            List{
                // Header
                LazyVGrid(columns: cols,alignment: .leading){
                    Group{
                        Text("Intitulé: ")
                        Text(technicalDocumentVM.name)
                        Text("Responsable: ")
                        Text(technicalDocumentVM.responsable)
                        Text("Nombre de Couverts: ")
                        Text(String(technicalDocumentVM.nbServed))
                    }
                    Group{
                        Text("Description: ")
                        Text(technicalDocumentVM.header)
                        Text("Auteur: ")
                        Text(technicalDocumentVM.author)
                        Text("Catégorie: ")
                        Text(technicalDocumentVM.category)
                    }
                }
                // Steps
                Text("Etapes").font(.title3)
                List{
                    ForEach(technicalDocumentVM.steps, id: \.id){step in
                        VStack(alignment: .leading){
                            Spacer().frame(height:15)
                            Text("\(step.title)").font(.system(size:24))
                            Divider()
                            Text("\(step.description)")
                            Divider()
                            if(step.ingredients.count>0){Text("Ingrédients:").underline()}
                            ForEach(step.ingredients, id: \.code){ingredient in
                                VStack(alignment: .leading){
                                    Text("Nom: \(ingredient.libelle)")
                                    Text("Quantité: \(ingredient.quantity)\(ingredient.unit)")
                                }
                            }
                        }
                        .listRowSeparatorTint(Color.red)
                    }
                }.listStyle(PlainListStyle())
                    .frame(minHeight: 200)
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
                Toggle("Montrer les couts:", isOn:$technicalDocumentVM.hideCosts)
            }
            HStack{
                NavigationLink(destination: EditTechdocView()){
                    Text("Modifier")
                }.frame(width: 90)
                    .padding(3)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 5)
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
                    .alert("Êtes-vous sûr de supprimer cette fiche technique?", isPresented: $showingDeleteConfirm){
                        Button("Oui", role: .destructive){
                            technicalDocumentListVM.technicalDocumentListState.intentToChange(delete: technicalDocumentVM.getTechnicalDocumentReference())
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        Button("Non", role: .cancel){
                            // does nothing
                        }
                    }
            }
        }
        .onChange(of: technicalDocumentVM.technicalDocumentState, perform: {
            newValue in changeValue(newValue)
        })
        .navigationTitle(technicalDocumentVM.name)
    }
    
    private func changeValue(_ newValue: TechnicalDocumentIntent){
        switch newValue{
        case .editedTechnicalDocument(_), .cancelledTechnicalDocumentModifications:
            technicalDocumentVM.technicalDocumentState = .ready
        default:
            return
        }
    }
}

struct TechdocView_Previews: PreviewProvider {
    static var previews: some View {
        TechdocView()
    }
}
