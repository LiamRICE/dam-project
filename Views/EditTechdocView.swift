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
            Text("Etapes")
            List{
                ForEach($technicalDocumentVM.steps, id: \.id){$step in
                    VStack{
                        LazyVGrid(columns: cols,alignment: .leading){
                            Text("Titre: ")
                            TextField("",text:$step.title)
                        }
                        VStack{
                            Text("Description: ")
                            TextField("",text:$step.description)
                        }
                        if($step.ingredients.count>0){Text("Ingrédients:")}
                        ForEach($step.ingredients, id: \.code){$ingredient in
                            LazyVGrid(columns: cols,alignment: .leading){
                                Text("Nom: ")
                                TextField("",text:$ingredient.libelle)
                                Text("Quantité: ")
                                LazyVGrid(columns: cols,alignment: .leading){
                                    TextField("",value: $ingredient.quantity,formatter:formatter)
                                    TextField("",text: $ingredient.unit)
                                }
                            }
                        }
                    }
                }
            }
            // Footer
            LazyVGrid(columns:cols, alignment:.leading){
                Text("Cacher les couts:")
                Text("Utiliser paramètres du système:")
                Text("Utiliser charges:")
            }
            HStack{
                Button("Modifier"){
                    // TODO - confirm modifications
                    technicalDocumentVM.technicalDocumentState.intentToChange(document: TechnicalDocument(id: technicalDocumentVM.id, name: technicalDocumentVM.name, header: technicalDocumentVM.header, author: technicalDocumentVM.author, respo: technicalDocumentVM.responsable, cat: technicalDocumentVM.category, nbServed: technicalDocumentVM.nbServed, def: technicalDocumentVM.byDefault, charges: technicalDocumentVM.usesCharges, ass: technicalDocumentVM.assaisonnemments, steps: technicalDocumentVM.steps))
                }
                Button("Annuler"){
                    // TODO - reset modifications
                }
            }
            HStack{
                Button("Ajouter un étape"){
                    // TODO - add a step
                }
                Button("Ajouter un ingrédient"){
                    // TODO - add an ingredient
                }
            }
        }
        .onChange(of: technicalDocumentVM.technicalDocumentState, perform: {
            newValue in changeValue(newValue)
        })
    }
    
    private func changeValue(_ newValue: TechnicalDocumentIntent){
        switch newValue{
        case .editedTechnicalDocument(_):
            technicalDocumentVM.technicalDocumentState = .ready
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
