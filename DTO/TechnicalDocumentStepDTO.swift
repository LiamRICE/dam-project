//
//  TechnicalDocumentStepDTO.swift
//  dam-project
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI

public class TechnicalDocumentStepDTO: Codable{
    var id: Int?
    var stepid: Int?
    var title: String
    var description: String
    var time: Int
    
    init(id: Int, title: String, desc: String, time: Int){
        self.id = id
        self.stepid = id
        self.title = title
        self.description = desc
        self.time = time
    }

    enum CodingKeys: String, CodingKey{
        case id = "id"
        case stepid = "stepid"
        case title = "title"
        case description = "description"
        case time = "time"
    }

    func getStepID() -> Int{
        if let ret=id{
            return ret
        }
        if let ret=stepid{
            return ret
        }
        return -1
    }
}
