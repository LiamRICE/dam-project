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
    @Published var hideCosts: Bool
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
        self.hideCosts = false
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
    
    public func getTechnicalDocumentReference() -> TechnicalDocument{
        return self.model
    }
    
    public func calculateMatterCosts() -> Double{
        var sum: Double = 0
        for step in self.steps{
            for ingredient in step.ingredients{
                sum += ingredient.quantity * ingredient.unitprice
            }
        }
        return sum
    }
    
    public func calculateFluidCosts(costs: Costs) -> Double{
        var sum: Double = 0
        if(self.byDefault){
            if(costs.usesCharges){
                for step in self.steps{
                    sum += (Double(step.time) / 60) * costs.fluides
                }
            }
        } else {
            if(self.usesCharges){
                for step in self.steps{
                    sum += (Double(step.time) / 60) * costs.fluides
                }
            }
        }
        return sum
    }
    
    public func calculatePersonnelCosts(costs: Costs) -> Double{
        var sum: Double = 0
        if(self.byDefault){
            if(costs.usesCharges){
                for step in self.steps{
                    sum += (Double(step.time) / 60) * costs.personnel
                }
            }
        } else {
            if(self.usesCharges){
                for step in self.steps{
                    sum += (Double(step.time) / 60) * costs.personnel
                }
            }
        }
        return sum
    }
    
    public func calculateSeasoningCosts() -> Double{
        if(self.assaisonnemments <= 0){
            return calculateMatterCosts() * 0.05
        } else{
            return self.assaisonnemments
        }
    }
    
    public func totalCosts(costs: Costs) -> Double{
        return calculateMatterCosts() + calculateFluidCosts(costs: costs) + calculatePersonnelCosts(costs: costs) + calculateSeasoningCosts()
    }
    
    public func calculateSalesPrice(costs: Costs, byPortions: Bool) -> Double{
        var sum: Double = 0
        if(self.byDefault){
            if(costs.usesCharges){
                sum = totalCosts(costs: costs) * (costs.markup / 100)
            } else {
                sum = totalCosts(costs: costs) * (costs.markupNoCharges / 100)
            }
        } else {
            if(self.usesCharges){
                sum = totalCosts(costs: costs) * (costs.markup / 100)
            } else {
                sum = totalCosts(costs: costs) * (costs.markupNoCharges / 100)
            }
        }
        if(byPortions){
            if(self.nbServed != 0){
                return sum / Double(self.nbServed)
            }else{
                return sum
            }
        } else {
            return sum
        }
    }
    
    public func calculateProfitByPortion(costs: Costs) -> Double{
        let c = totalCosts(costs: costs)
        let v = calculateSalesPrice(costs: costs, byPortions: true) / 1.1
        return v - (c / Double(self.nbServed))
    }
    
    public func rentabilityLimit(costs: Costs) -> Int{
        let varCosts = calculateMatterCosts() + calculateSeasoningCosts()
        let fixCosts = calculatePersonnelCosts(costs: costs) + calculateFluidCosts(costs: costs)
        let sales = calculateSalesPrice(costs: costs, byPortions: true) / 1.1
        var mcv: Double = 1
        if(sales == 0 || self.nbServed == 0){
            mcv = 1
        }else{
            mcv = (sales - varCosts / Double(self.nbServed)) / sales
        }
        var result: Double = fixCosts
        if(mcv != 0){
            result = fixCosts / mcv
        }else{
            result = fixCosts
        }
        if(fixCosts == 0){
            result = totalCosts(costs: costs) / mcv
        }
        return Int(result)
    }
}
