//
//  DataDAO.swift
//  dam-project
//
//  Created by m1 on 17/02/2022.
//

import Foundation
import SwiftUI

public class DataDAO{
    
    static func getIngredientList() async -> [Ingredient]{
        var ingredientList: [Ingredient] = []
        if let url = URL(string: "https://awi-backend.herokuapp.com/ingredient/get/all"){
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([IngredientDTO].self, from: data){
                    for iDTO in decoded{
                        ingredientList.append(DataDAO.translate(ingredientdto: iDTO))
                    }
                }else{
                    print("error decoding data")
                }
            }catch{
                // print
            }
        }
        return ingredientList
    }
    
    static func postIngredient(ingredient: Ingredient) async{
        if let encoded = try? JSONEncoder().encode(DataDAO.translate(ingredient: ingredient)){
            if let url = URL(string: "https://awi-backend.herokuapp.com/ingredient/post"){
                do{
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.httpBody = encoded
                    request.addValue("application/json", forHTTPHeaderField: "content-type")
                    if let (_, response) = try? await URLSession.shared.upload(for: request, from:encoded){
                        let httpresponse = response as! HTTPURLResponse
                        if httpresponse.statusCode == 201 {
                            print("done")
                        }
                        else{
                            print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                        }
                    }
                }
            }
        }
    }
    
    static func putIngredient(ingredient: Ingredient) async {
        print(ingredient.libelle)
        if let encoded = try? JSONEncoder().encode(DataDAO.translate(ingredient: ingredient)){
            if let url = URL(string: "https://awi-backend.herokuapp.com/ingredient/put/\(ingredient.code)"){
                do{
                    var request = URLRequest(url: url)
                    request.httpMethod = "PUT"
                    request.httpBody = encoded
                    request.addValue("application/json", forHTTPHeaderField: "content-type")
                    if let (_, response) = try? await URLSession.shared.data(for: request){
                        let httpresponse = response as! HTTPURLResponse
                        if(httpresponse.statusCode==200){
                            print("done")
                        }else{
                            print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                        }
                    }
                }
            }
        }
    }
    
    private static func translate(ingredientdto: IngredientDTO) -> Ingredient{
        return Ingredient(code: ingredientdto.code, libelle: ingredientdto.libelle, unit: ingredientdto.unit, unitprice: ingredientdto.unitprice, stocks: ingredientdto.stocks, stockvalue: ingredientdto.stockvalue, allergene: ingredientdto.allergene==1)
    }
    private static func translate(ingredient: Ingredient) -> IngredientDTO{
        return IngredientDTO(code: ingredient.code, libelle: ingredient.libelle, unit: ingredient.unit, unitprice: ingredient.unitPrice, stocks: ingredient.stocks, stockvalue: ingredient.stockValue, allergene: ingredient.allergen ? 1 : 0)
    }
    private static func translate(techdocdto: TechnicalDocumentDTO) -> TechnicalDocument{
        var steps : [Step] = []
        
        for step in techdocdto.steps{
            var ingredients : [Ingredient] = []
            for ingredient in step.ingredients {
                let newingredient = Ingredient(code: ingredient.code, libelle: ingredient.libelle, unit: ingredient.unit, unitprice: ingredient.unitprice, stocks: ingredient.stocks, stockvalue: ingredient.stockvalue, allergene: ingredient.allergene==1)
                ingredients.append(newingredient)
            }
            let newstep = Step(id: step.id, title: step.title, desc: step.description, time: step.time, rk: step.rank, ingredients: ingredients)
            steps.append(newstep)
        }
        
        return TechnicalDocument(id: techdocdto.id, name: techdocdto.name, header: techdocdto.header, author: techdocdto.author, respo: techdocdto.responsable, cat: techdocdto.category, nbServed: techdocdto.nbServed, def: techdocdto.byDefault==1, charges: techdocdto.usesCharges==1, ass: techdocdto.assaisonnemments, steps: steps)
    }
    
    static func getTechnicaldocList() async -> [TechnicalDocument]{
        var docList: [TechnicalDocument] = []
        if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/get/all"){
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([TechnicalDocumentDTO].self, from: data){
                    for dto in decoded{
                        docList.append(DataDAO.translate(techdocdto: dto))
                    }
                    print(docList)
                }else{
                    print("error decoding data")
                }
            }catch{
                // print
            }
        }
        return docList
    }
}
