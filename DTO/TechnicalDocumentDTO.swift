//
//  TechnicalDocumentDTO.swift
//  dam-project
//
//  Created by m1 on 17/02/2022.
//

import Foundation

public class TechnicalDocumentDTO: Decodable, Encodable{
    var id: Int
    var name: String
    var header: String
    var author: String
    var responsable: String
    var category: String
    var nbServed: Int
    var byDefault: Int
    var usesCharges: Int
    var assaisonnemments: Double
    var steps: [StepDTO]
    
    init(id: Int, name: String, header: String, author: String, respo: String, cat: String, nbServed: Int, def: Int, charges: Int, ass: Double, steps: [StepDTO]){
        self.id = id
        self.name = name
        self.header = header
        self.author = author
        self.responsable = respo
        self.category = cat
        self.nbServed = nbServed
        self.byDefault = def
        self.usesCharges = charges
        self.assaisonnemments = ass
        self.steps = steps
    }
}
