//
//  IngredientInStepDTO.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI

public class IngredientInStepDTO: Codable{
    var stepid: Int
    var ingredientcode: Int
    var quantity: Double
    
    init(id: Int, code: Int, quantity: Double){
        self.stepid = id
        self.ingredientcode = code
        self.quantity = quantity
    }
}
