//
//  CostsIntent.swift
//  dam-project
//
//  Created by m1 on 03/03/2022.
//

import Foundation

public enum CostsIntent: Equatable{
    case ready
    case modifyingCosts(Costs)
    case modifiedCosts(Costs)
    case cancellingCosts
    case cancelledCosts
    
    mutating func intentToChange(modyfing: Costs){
        self = .modifyingCosts(modyfing)
    }
    
    mutating func intentToChange(cancel: Bool){
        self = .cancellingCosts
    }
}
