//
//  IngredientIntent.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import Foundation

public enum IngredientIntent{
    case ready
    case changingLibelle(String)
    case changedLibelle(String)
    case changingUnit(String)
    case changedUnit(String)
    case changingUnitPrice(Double)
    case changedUnitPrice(Double)
}
