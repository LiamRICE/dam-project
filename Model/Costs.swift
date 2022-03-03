//
//  Costs.swift
//  dam-project
//
//  Created by m1 on 03/03/2022.
//

import Foundation

public class Costs: Equatable{
    var fluides: Double
    var personnel: Double
    var markup: Double
    var markupNoCharges: Double
    var usesCharges: Bool
    
    init(fluides: Double, pers: Double, mark: Double, markNo: Double, charges: Bool){
        self.fluides = fluides
        self.personnel = pers
        self.markup = mark
        self.markupNoCharges = markNo
        self.usesCharges = charges
    }
    
    init(){
        self.fluides = 0
        self.personnel = 0
        self.markup = 0
        self.markupNoCharges = 0
        self.usesCharges = true
    }
    
    public static func == (lhs: Costs, rhs: Costs) -> Bool {
        return lhs.fluides == rhs.fluides && rhs.personnel == lhs.personnel && lhs.markup == rhs.markup && lhs.markupNoCharges == rhs.markupNoCharges && lhs.usesCharges == rhs.usesCharges
    }
}
