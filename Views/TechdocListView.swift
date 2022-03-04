//
//  TechdocListView.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct TechdocListView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var technicalDocumentListVM: TechnicalDocumentListVM
    @EnvironmentObject var technicalDocumentVM: TechnicalDocumentVM
    
    private func stateChanged(_ newValue: TechnicalDocumentListIntent){
        switch newValue {
        case .searchedTechnicalDocumentList(_):
            technicalDocumentListVM.technicalDocumentListState = .ready
        default:
            return
        }
    }
    
    var body: some View {
        VStack{
            NavigationLink(destination: AddTechdocView()){
                Text("Ajouter une fiche")
            }.onAppear(perform: {
                technicalDocumentVM.setTechnicalDocument(doc: TechnicalDocument())
            })
            LazyVGrid(columns:cols, alignment:.leading){
                Picker("Catégorie", selection: $technicalDocumentListVM.category){
                    ForEach(technicalDocumentListVM.getCategories(), id:\.self){ category in
                        Text(category).tag(category)
                    }
                }
                TextField("search", text: $technicalDocumentListVM.regex)
            }
            Button("Chercher"){
                let searchObject = TechnicalDocumentListSearch()
                searchObject.setCategory(cat: technicalDocumentListVM.category)
                searchObject.setSearch(search: technicalDocumentListVM.regex)
                technicalDocumentListVM.technicalDocumentListState.intentToChange(search: searchObject)
            }
            List{
                ForEach(technicalDocumentListVM.techdocs, id: \.id){
                    document in NavigationLink(destination: TechdocView().onAppear(perform:{
                        technicalDocumentVM.setTechnicalDocument(doc: document)
                    })){
                        Text("\(document.name)")
                    }
                }
            }
        }.onChange(of: technicalDocumentListVM.technicalDocumentListState, perform: {
            newValue in stateChanged(newValue)
        })
            .navigationTitle("Fiches Techniques")
    }
}

struct TechdocListView_Previews: PreviewProvider {
    static var previews: some View {
        TechdocListView()
    }
}
