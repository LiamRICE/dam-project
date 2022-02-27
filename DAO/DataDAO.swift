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
                        ingredientList.append(IngredientDTO.translate(ingredientdto: iDTO))
                    }
                }else{
                    print("error decoding ingredient data")
                }
            }catch{
                // print
            }
        }
        return ingredientList
    }
    
    static func postIngredient(ingredient: Ingredient) async{
        if let encoded = try? JSONEncoder().encode(IngredientDTO.translate(ingredient: ingredient)){
            if let url = URL(string: "https://awi-backend.herokuapp.com/ingredient/post"){
                do{
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.httpBody = encoded
                    request.addValue("application/json", forHTTPHeaderField: "content-type")
                    if let (_, response) = try? await URLSession.shared.data(for: request){
                        let httpresponse = response as! HTTPURLResponse
                        if httpresponse.statusCode == 200 {
                            print("Ingredient posted")
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
        if let encoded = try? JSONEncoder().encode(IngredientDTO.translate(ingredient: ingredient)){
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
    
    static func getTechnicaldocList() async -> [TechnicalDocument]{
        var docList: [TechnicalDocument] = []
        if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/get/all"){
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([TechnicalDocumentDTO].self, from: data){
                    for dto in decoded{
                        print(dto)
                        docList.append(TechnicalDocumentDTO.translate(techdocdto: dto))
                    }
                    print(docList)
                }else{
                    print("error decoding technical document data")
                }
            }catch{
                // print
            }
        }
        return docList
    }
    
    static func putTechnicalDocHeader(doc: TechnicalDocument) async {
        let header = TechnicalDocumentHeaderDTO(id: doc.id, name: doc.name, head: doc.header, auth: doc.author, resp: doc.responsable, cat: doc.category, def: doc.byDefault, charges: doc.usesCharges, served: doc.nbServed, ass: doc.assaisonnemments)
        if let encoded = try? JSONEncoder().encode(header){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/put/header"){
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
    
    static func putTechnicalDocStep(doc: TechnicalDocument, step: Step) async {
        let stepdto = TechnicalDocumentStepDTO(id: step.id, title: step.title, desc: step.description, time: step.time)
        if let encoded = try? JSONEncoder().encode(stepdto){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/put/step"){
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
        let stepinheader = StepInHeaderDTO(doc: doc.id, step: step.id, rk: step.rank)
        if let encoded = try? JSONEncoder().encode(stepinheader){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/put/stepinheader"){
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
    
    static func putTechnicalDocIngredientInStep(step: Step, ingredient: StepIngredient) async {
        let ingredientinstep = IngredientInStepDTO(id: step.id, code: ingredient.code, quantity: ingredient.quantity)
        if let encoded = try? JSONEncoder().encode(ingredientinstep){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/put/ingredientinstep"){
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
    
    static func postTechnicalDocHeader(doc: TechnicalDocument) async {
        let header = TechnicalDocumentHeaderDTO(id: doc.id, name: doc.name, head: doc.header, auth: doc.author, resp: doc.responsable, cat: doc.category, def: doc.byDefault, charges: doc.usesCharges, served: doc.nbServed, ass: doc.assaisonnemments)
        if let encoded = try? JSONEncoder().encode(header){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/post/header"){
                do{
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
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
}
