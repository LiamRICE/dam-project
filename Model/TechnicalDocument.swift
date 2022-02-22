//
//  TechnicalDocument.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public class TechnicalDocument: Equatable{
    
    var id: Int
    var name: String
    var header: String
    var author: String
    var responsable: String
    var category: String
    var nbServed: Int
    var byDefault: Bool
    var usesCharges: Bool
    var assaisonnemments: Double
    var steps: [Step]
    
    init(id: Int, name: String, header: String, author: String, respo: String, cat: String, nbServed: Int, def: Bool, charges: Bool, ass: Double, steps: [Step]){
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
    
    init(){
        self.id = 0
        self.name = "name"
        self.header = "header"
        self.author = "author"
        self.responsable = "respo"
        self.category = "cat"
        self.nbServed = 0
        self.byDefault = true
        self.usesCharges = true
        self.assaisonnemments = 0
        self.steps = []
    }
    
    public static func == (lhs: TechnicalDocument, rhs: TechnicalDocument) -> Bool {
        return lhs.id == rhs.id
    }
}
