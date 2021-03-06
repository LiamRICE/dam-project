//
//  TechnicalDocumentStepDTO.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI
import Foundation

public class StepInHeaderDTO: Codable{
    var docid: Int
    var stepid: Int
    var rank: Int
    
    init(doc: Int, step: Int, rk: Int){
        self.docid = doc
        self.stepid = step
        self.rank = rk
    }
}
