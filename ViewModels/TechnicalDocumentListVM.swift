//
//  TechnicalDocumentListVM.swift
//  dam-project
//
//  Created by m1 on 21/02/2022.
//

import Foundation

public class TechnicalDocumentListVM: ObservableObject{
    private var model: [TechnicalDocument]
    @Published var techdocs: [TechnicalDocument]
    @Published var technicalDocumentListState: TechnicalDocumentListIntent = .ready{
        didSet{
            switch self.technicalDocumentListState{
            case .addingTechnicalDocument(let document):
                // post techdoc
                self.techdocs.append(document)
                self.techdocs.sort(by: {
                    i1, i2 in return i1.id < i2.id
                })
                self.model = self.techdocs
                self.technicalDocumentListState = .addedTechnicalDocument(document)
            case .changingTechnicalDocumentList:
                self.techdocs.sort(by: {
                    i1, i2 in return i1.id < i2.id
                })
                self.model = self.techdocs
                self.technicalDocumentListState = .changedTechnicalDocumentList
            default:
                return
            }
        }
    }
    
    init(){
        self.model = []
        self.techdocs = []
    }
    
    func loadModel() async {
        self.model = await DataDAO.getTechnicaldocList()
        self.techdocs = self.model
    }
}
