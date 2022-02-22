//
//  TechnicalDocumentVM.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import Foundation

public class TechnicalDocumentVM: ObservableObject{
    private var model: TechnicalDocument
    @Published var id: Int
    @Published var name: String
    @Published var header: String
    @Published var author: String
    @Published var responsable: String
    @Published var category: String
    @Published var nbServed: Int
    @Published var byDefault: Bool
    @Published var usesCharges: Bool
    @Published var assaisonnemments: Double
    @Published var steps: [Step]
    @Published var technicalDocumentState: TechnicalDocumentIntent = .ready{
        didSet{
            switch self.technicalDocumentState{
            case .editingTechnicalDocument(let doc):
                self.id = doc.id
                self.name = doc.name
                self.header = doc.header
                self.author = doc.author
                self.responsable = doc.responsable
                self.category = doc.category
                self.nbServed = doc.nbServed
                self.byDefault = doc.byDefault
                self.usesCharges = doc.usesCharges
                self.assaisonnemments = doc.assaisonnemments
                self.steps = doc.steps
                self.technicalDocumentState = .editedTechnicalDocument(doc)
            default:
                return
            }
        }
    }
    
    init(){
        self.model = TechnicalDocument()
        self.id = 0
        self.name = "name"
        self.header = "header"
        self.author = "author"
        self.responsable = "respo"
        self.category = "cat"
        self.nbServed = 0
        self.byDefault = true
        self.usesCharges = true
        self.assaisonnemments = 0
        self.steps = []
    }
    
    public func setTechnicalDocument(doc: TechnicalDocument){
        self.model = doc
        self.id = doc.id
        self.name = doc.name
        self.header = doc.header
        self.author = doc.author
        self.responsable = doc.responsable
        self.category = doc.category
        self.nbServed = doc.nbServed
        self.byDefault = doc.byDefault
        self.usesCharges = doc.usesCharges
        self.assaisonnemments = doc.assaisonnemments
        self.steps = doc.steps
    }
}
