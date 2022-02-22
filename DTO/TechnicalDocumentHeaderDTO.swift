//
//  TechnicalDocumentHeaderDTO.swift
//  dam-project
//
//  Created by Liam RICE on 22/02/2022.
//

import SwiftUI
import Foundation

public class TechnicalDocumentHeaderDTO: Codable{
    var id: Int
    var name: String
    var header: String
    var author: String
    var responsable: String
    var category: String
    var def: Int
    var usecharges: Int
    var nbserved: Int
    var assaisonemments: Double
        
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case header = "header"
        case author = "author"
        case responsable = "responsable"
        case category = "category"
        case def = "default"
        case usecharges = "usecharges"
        case nbserved = "nbserved"
        case assaisonemments = "assaisonemments"
    }
}
