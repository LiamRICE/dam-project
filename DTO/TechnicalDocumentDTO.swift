//
//  TechnicalDocumentDTO.swift
//  dam-project
//
//  Created by m1 on 17/02/2022.
//

import Foundation

public class TechnicalDocumentDTO: Codable{
    var id: Int
    var name: String
    var header: String
    var author: String
    var responsable: String
    var category: String
    var nbserved: Int
    var isdefault: Int
    var usecharges: Int
    var assaisonemments: Double
    var steps: [StepDTO]
    
    init(id: Int, name: String, header: String, author: String, respo: String, cat: String, nbServed: Int, def: Int, charges: Int, ass: Double, steps: [StepDTO]){
        self.id = id
        self.name = name
        self.header = header
        self.author = author
        self.responsable = respo
        self.category = cat
        self.nbserved = nbServed
        self.isdefault = def
        self.usecharges = charges
        self.assaisonemments = ass
        self.steps = steps
    }
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case header = "header"
        case author = "author"
        case responsable = "responsable"
        case category = "category"
        case nbserved = "nbserved"
        case isdefault = "default"
        case usecharges = "usecharges"
        case assaisonemments = "assaisonemments"
        case steps = "steps"
    }
    
    public static func translate(techdocdto: TechnicalDocumentDTO) -> TechnicalDocument{
        var steps : [Step] = []
        
        for step in techdocdto.steps{
            var ingredients : [StepIngredient] = []
            for ingredient in step.ingredients {
                let newingredient = StepIngredient(code: ingredient.code, libelle: ingredient.libelle, quantity: ingredient.quantity, unit: ingredient.unit, unitprice: ingredient.unitprice, allergene: ingredient.allergen==1)
                ingredients.append(newingredient)
            }
            let newstep = Step(id: step.stepid, title: step.title, desc: step.description, time: step.time, rk: step.rank, ingredients: ingredients)
            steps.append(newstep)
        }
        
        return TechnicalDocument(id: techdocdto.id, name: techdocdto.name, header: techdocdto.header, author: techdocdto.author, respo: techdocdto.responsable, cat: techdocdto.category, nbServed: techdocdto.nbserved, def: techdocdto.isdefault==1, charges: techdocdto.usecharges==1, ass: techdocdto.assaisonemments, steps: steps)
    }
    
    public static func translate(techdoc: TechnicalDocument) -> TechnicalDocumentDTO{
        var steps : [StepDTO] = []
        
        for step in techdoc.steps{
            var ingredients : [StepIngredientDTO] = []
            for ingredient in step.ingredients {
                let newingredient = StepIngredientDTO(code: ingredient.code, libelle: ingredient.libelle, quantity: ingredient.quantity, unit: ingredient.unit, unitprice: ingredient.unitprice, allergen: ingredient.allergene ? 1 : 0)
                ingredients.append(newingredient)
            }
            let newstep = StepDTO(id: step.id, title: step.title, desc: step.description, time: step.time, rk: step.rank, ingredients: ingredients)
            steps.append(newstep)
        }
        
        return TechnicalDocumentDTO(id: techdoc.id, name: techdoc.name, header: techdoc.header, author: techdoc.author, respo: techdoc.responsable, cat: techdoc.category, nbServed: techdoc.nbServed, def: techdoc.byDefault ? 1 : 0, charges: techdoc.usesCharges ? 1 : 0, ass: techdoc.assaisonnemments, steps: steps)
    }
}
