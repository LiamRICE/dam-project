//
//  CostsDTO.swift
//  dam-project
//
//  Created by m1 on 03/03/2022.
//

import Foundation

public class CostsDTO: Codable{
    var fluides: Double
    var personnel: Double
    var markup: Double
    var markupnocharges: Double
    var charges: Int
    
    init(fluides: Double, pers: Double, markup: Double, markupnocharges: Double, charges: Int){
        self.fluides = fluides
        self.personnel = pers
        self.markup = markup
        self.markupnocharges = markupnocharges
        self.charges = charges
    }
    
    public static func translate(costs: Costs) -> CostsDTO{
        return CostsDTO(fluides: costs.fluides, pers: costs.personnel, markup: costs.markup, markupnocharges: costs.markupNoCharges, charges: costs.usesCharges ? 1 : 0)
    }
    
    public static func translate(costsdto: CostsDTO) -> Costs{
        return Costs(fluides: costsdto.fluides, pers: costsdto.personnel, mark: costsdto.markup, markNo: costsdto.markupnocharges, charges: costsdto.charges == 1)
    }
}
