//
//  CostsVM.swift
//  dam-project
//
//  Created by m1 on 03/03/2022.
//

import Foundation

public class CostsVM: ObservableObject{
    private var model: Costs
    @Published var fluidCost: Double
    @Published var personnelCost: Double
    @Published var markupWithCharges: Double
    @Published var markupWithoutCharges: Double
    @Published var usesChargesByDefault: Bool
    @Published var costsState: CostsIntent = .ready{
        didSet{
            switch self.costsState{
            case .modifyingCosts(let costs):
                Task{await DataDAO.putCosts(costs: costs)}
                self.model.fluides = costs.fluides
                self.model.personnel = costs.personnel
                self.model.markup = costs.markup
                self.model.markupNoCharges = costs.markupNoCharges
                self.model.usesCharges = costs.usesCharges
                self.costsState = .modifiedCosts(costs)
            case .cancellingCosts:
                self.fluidCost = self.model.fluides
                self.personnelCost = self.model.personnel
                self.markupWithCharges = self.model.markup
                self.markupWithoutCharges = self.model.markupNoCharges
                self.usesChargesByDefault = self.model.usesCharges
                self.costsState = .cancelledCosts
            default:
                return
            }
        }
    }
    
    init(){
        self.model = Costs()
        self.fluidCost = 0
        self.personnelCost = 0
        self.markupWithCharges = 0
        self.markupWithoutCharges = 0
        self.usesChargesByDefault = true
    }
    
    public func loadModel(){
        Task{
            self.model = await DataDAO.getCosts()
            self.fluidCost = model.fluides
            self.personnelCost = model.personnel
            self.markupWithCharges = model.markup
            self.markupWithoutCharges = model.markupNoCharges
            self.usesChargesByDefault = model.usesCharges
        }
    }
}
