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
    
    var body: some View {
        VStack{
            // Header
            VStack{
                Text("Intitulé: \(technicalDocumentVM.name)")
                Text("Responsable:\(technicalDocumentVM.responsable)")
                Text("Nombre de Couverts:\(technicalDocumentVM.nbServed)")
                Text("Description:\(technicalDocumentVM.header)")
                Text("Auteur:\(technicalDocumentVM.author)")
                Text("Catégorie:\(technicalDocumentVM.category)")
            }
            // Steps
            Text("Etapes")
            List{
                ForEach(technicalDocumentVM.steps, id: \.id){step in
                    VStack{
                        Text("\(step.title)")
                        Text("\(step.description)")
                        if(step.ingredients.count>0){Text("Ingrédients:")}
                        ForEach(step.ingredients, id: \.code){ingredient in
                            VStack{
                                Text("Nom: \(ingredient.libelle)")
                                Text("Quantité: \(ingredient.quantity)\(ingredient.unit)")
                            }
                        }
                    }
                }
            }
            LazyVGrid(columns:cols, alignment:.leading){
                Toggle("Cacher les couts:", isOn:$technicalDocumentVM.hideCosts)
            }
            HStack{
                NavigationLink(destination: EditTechdocView()){
                    Text("Modifier")
                }
            }
        }
        .onChange(of: technicalDocumentVM.technicalDocumentState, perform: {
            newValue in changeValue(newValue)
        })
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
