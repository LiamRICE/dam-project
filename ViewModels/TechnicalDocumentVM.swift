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
                Task{
                    await DataDAO.putTechnicalDocHeader(doc: doc)
                    for step in doc.steps{
                        await DataDAO.putTechnicalDocStep(doc: doc, step: step)
                        for ingredient in step.ingredients{
                            await DataDAO.putTechnicalDocIngredientInStep(step: step, ingredient: ingredient)
                        }
                    }
                }
                self.model.id = doc.id
                self.model.name = doc.name
                self.model.header = doc.header
                self.model.author = doc.author
                self.model.responsable = doc.responsable
                self.model.category = doc.category
                self.model.nbServed = doc.nbServed
                self.model.byDefault = doc.byDefault
                self.model.usesCharges = doc.usesCharges
                self.model.assaisonnemments = doc.assaisonnemments
                self.model.steps = doc.steps
                steps.sort(by: {
                    i1, i2 in return i1.rank < i2.rank
                })
                self.technicalDocumentState = .editedTechnicalDocument(doc)
            case .cancellingTechnicalDocumentModifications:
                self.id = self.model.id
                self.name = self.model.name
                self.header = self.model.header
                self.author = self.model.author
                self.responsable = self.model.responsable
                self.category = self.model.category
                self.nbServed = self.model.nbServed
                self.byDefault = self.model.byDefault
                self.usesCharges = self.model.usesCharges
                self.assaisonnemments = self.model.assaisonnemments
                self.steps = self.model.steps
                steps.sort(by: {
                    i1, i2 in return i1.rank < i2.rank
                })
                self.technicalDocumentState = .cancelledTechnicalDocumentModifications
            case .addingTechnicalDocument(let doc):
                self.technicalDocumentState = .addedTechnicalDocument(doc)
            case .addingStepToDocument(let step):
                Task{
                    await DataDAO.postTechnicalDocStep(doc: self.model, step: step)
                }
                self.steps.append(step)
                self.model.steps = self.steps
                self.technicalDocumentState = .addedStepToDocument(step)
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
    
    public func increaseStepRank(step: Step){
        var switched: Bool = false
        for s in self.steps{
            if(switched){
                s.rank -= 1
                switched = false
            }
            if(step == s){
                if(step.rank<self.steps.count-1){
                    step.rank += 1
                    switched = true
                }
            }
        }
        steps.sort(by: {
            i1, i2 in return i1.rank < i2.rank
        })
    }
    
    public func decreaseStepRank(step: Step){
        var switched: Bool = false
        for s in self.steps.reversed(){
            if(switched){
                s.rank += 1
                switched = false
            }
            if(step == s){
                if(step.rank>0){
                    step.rank -= 1
                    switched = true
                }
            }
        }
        steps.sort(by: {
            i1, i2 in return i1.rank < i2.rank
        })
    }
}
