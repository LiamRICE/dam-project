//
//  TechdocListView.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct TechdocListView: View {
    
    @EnvironmentObject var technicalDocumentListVM: TechnicalDocumentListVM
    @EnvironmentObject var technicalDocumentVM: TechnicalDocumentVM
    /*
    private func stateChanged(_ newValue: IngredientListIntent){
        switch newValue {
        case .changedIngredientList:
            ingredientListVM.ingredientListState = .ready
            print("List State : ready")
        default:
            return
        }
    }
    
    private func searchList(search: String) -> [Ingredient]{
        return ingredientListVM.subset(searchValue: search)
    }
    */
    var body: some View {
        VStack{
            NavigationLink(destination: AddIngredientView()){
                Text("Ajouter une fiche")
            }
            List{
                ForEach(technicalDocumentListVM.techdocs, id: \.id){
                    document in NavigationLink(destination: TechdocView().onAppear(perform: {
                        technicalDocumentVM.setTechnicalDocument(doc: document)
                    })){
                        Text("\(document.name)")
                    }
                }
            }
        }/*.onChange(of: technicalDocumentListVM, perform: {
            newValue in stateChanged(newValue)
        })*/
    }
}

struct TechdocListView_Previews: PreviewProvider {
    static var previews: some View {
        TechdocListView()
    }
}
