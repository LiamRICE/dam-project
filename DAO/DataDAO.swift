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
    
    static func deleteIngredient(ingredient: Ingredient) async {
        print(ingredient.libelle)
        if let url = URL(string: "https://awi-backend.herokuapp.com/ingredient/delete/\(ingredient.code)"){
            do{
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
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
    
    static func postTechnicalDocStep(doc: TechnicalDocument, step: Step) async {
        let stepdto = TechnicalDocumentStepDTO(id: step.id, title: step.title, desc: step.description, time: step.time)
        if let encoded = try? JSONEncoder().encode(stepdto){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/post/step"){
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
        let stepinheader = StepInHeaderDTO(doc: doc.id, step: step.id, rk: step.rank)
        if let encoded = try? JSONEncoder().encode(stepinheader){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/post/stepinheader"){
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
    
    static func postTechnicalDocIngredientInStep(step: Step, ingredient: StepIngredient) async {
        let ingredientinstep = IngredientInStepDTO(id: step.id, code: ingredient.code, quantity: ingredient.quantity)
        if let encoded = try? JSONEncoder().encode(ingredientinstep){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/post/ingredientinstep"){
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
    
    static func deleteTechnicalDocument(document: TechnicalDocument) async {
        let dto = TechnicalDocumentHeaderDTO(id: document.id, name: document.name, head: document.header, auth: document.author, resp: document.responsable, cat: document.category, def: document.byDefault, charges: document.usesCharges, served: document.nbServed, ass: document.assaisonnemments)
        if let encoded = try? JSONEncoder().encode(dto){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/delete"){
                do{
                    var request = URLRequest(url: url)
                    request.httpMethod = "DELETE"
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
    
    static func deleteStep(step: Step) async {
        let dto = StepDTO(id: step.id, title: step.title, desc: step.description, time: step.time, rk: step.rank, ingredients: [])
        if let encoded = try? JSONEncoder().encode(dto){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/delete/step"){
                do{
                    var request = URLRequest(url: url)
                    request.httpMethod = "DELETE"
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
    
    static func deleteIngredientFromStep(step: Step, stepIngredient: StepIngredient) async {
        let dto = IngredientInStepDTO(id: step.id, code: stepIngredient.code, quantity: stepIngredient.quantity)
        if let encoded = try? JSONEncoder().encode(dto){
            if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/delete/ingredientinstep"){
                do{
                    var request = URLRequest(url: url)
                    request.httpMethod = "DELETE"
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
    
    static func getCosts() async -> Costs{
        var costs: Costs = Costs()
        if let url = URL(string: "https://awi-backend.herokuapp.com/costs/get"){
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(CostsDTO.self, from: data){
                    costs = CostsDTO.translate(costsdto: decoded)
                }else{
                    print("error decoding costs data")
                }
            }catch{
                // print
            }
        }
        return costs
    }
    
    static func putCosts(costs: Costs) async {
        if let encoded = try? JSONEncoder().encode(CostsDTO.translate(costs: costs)){
            if let url = URL(string: "https://awi-backend.herokuapp.com/costs/set"){
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
    
    static func getTickets() async -> [Ticket]{
        var ticketList: [Ticket] = []
        if let url = URL(string: "https://awi-backend.herokuapp.com/technicaldoc/tickets"){
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([TicketDTO].self, from: data){
                    for iDTO in decoded{
                        ticketList.append(TicketDTO.translate(ticketdto: iDTO))
                    }
                }else{
                    print("error decoding ingredient data")
                }
            }catch{
                // print
            }
        }
        return ticketList
    }
}
