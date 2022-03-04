//
//  TechnicalDocumentListVM.swift
//  dam-project
//
//  Created by m1 on 21/02/2022.
//

import Foundation

public class TechnicalDocumentListVM: ObservableObject{
    private var model: [TechnicalDocument]
    @Published var regex: String
    @Published var category: String
    @Published var techdocs: [TechnicalDocument]
    @Published var technicalDocumentListState: TechnicalDocumentListIntent = .ready{
        didSet{
            switch self.technicalDocumentListState{
            case .addingTechnicalDocument(let document):
                var isUsed = false
                for doc in model{
                    if doc == document{
                        isUsed = true
                    }
                }
                if !isUsed{
                    Task {await DataDAO.postTechnicalDocHeader(doc: document)}
                    self.techdocs = self.model
                    self.techdocs.append(document)
                    self.techdocs.sort(by: {
                        i1, i2 in return i1.id < i2.id
                    })
                    self.model = self.techdocs
                    self.technicalDocumentListState = .addedTechnicalDocument(document)
                }else{
                    self.technicalDocumentListState = .addTechnicalDocumentError(.duplicateError)
                }
            case .changingTechnicalDocumentList:
                self.techdocs.sort(by: {
                    i1, i2 in return i1.id < i2.id
                })
                self.model = self.techdocs
                self.technicalDocumentListState = .changedTechnicalDocumentList
            case .searchingTechnicalDocumentList(let search):
                self.techdocs = search.searchTechnicalDocuments(techdoc: self.model)
                self.technicalDocumentListState = .searchedTechnicalDocumentList(search)
            case .deletingTechnicalDocument(let techdoc):
                if let index = self.techdocs.firstIndex(of: techdoc){
                    Task{await DataDAO.deleteTechnicalDocument(document: techdoc)}
                    self.techdocs.remove(at: index)
                    self.model = self.techdocs
                    self.technicalDocumentListState = .deletedTechnicalDocument(techdoc)
                }
            default:
                return
            }
        }
    }
    
    init(){
        self.model = []
        self.techdocs = []
        self.category = "Tous"
        self.regex = ""
    }
    
    func loadModel() async {
        self.model = await DataDAO.getTechnicaldocList()
        self.techdocs = self.model
    }
    
    func getCategories() -> [String]{
        var array: [String] = ["Tous"]
        for techdoc in self.model{
            if !array.contains(techdoc.category){
                array.append(techdoc.category)
            }
        }
        return array
    }
    
    func getUnusedId() -> Int{
        var num: Int = 0
        for techdoc in self.model{
            if num <= techdoc.id{
                num = techdoc.id + 1
            }
        }
        return num
    }
    
    func getUnusedStepId() -> Int{
        var num: Int = 0
        for techdoc in self.model{
            for step in techdoc.steps{
                if num <= step.id{
                    num = step.id + 1
                }
            }
        }
        return num
    }
}
