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
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 5)
                    )
            }.padding(5).onAppear(perform: {
                technicalDocumentVM.setTechnicalDocument(doc: TechnicalDocument())
            })
            LazyVGrid(columns:cols, alignment:.leading){
                Picker("Catégorie", selection: $technicalDocumentListVM.category){
                    ForEach(technicalDocumentListVM.getCategories(), id:\.self){ category in
                        Text(category).tag(category)
                    }
                }.padding(.horizontal,20)
                TextField("search", text: $technicalDocumentListVM.regex)
            }
            Button("Rechercher"){
                let searchObject = TechnicalDocumentListSearch()
                searchObject.setCategory(cat: technicalDocumentListVM.category)
                searchObject.setSearch(search: technicalDocumentListVM.regex)
                technicalDocumentListVM.technicalDocumentListState.intentToChange(search: searchObject)
            }.padding(7).foregroundColor(Color.white).overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 5)
            ).background(Color.blue)
            List{
                ForEach(technicalDocumentListVM.techdocs, id: \.id){
                    document in NavigationLink(destination: TechdocView().onAppear(perform:{
                        technicalDocumentVM.setTechnicalDocument(doc: document)
                    })){
                        Text("\(document.name)")
                    }
                }
            }.listStyle(PlainListStyle())
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
