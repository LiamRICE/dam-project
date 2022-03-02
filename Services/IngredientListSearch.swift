//
//  SortObject.swift
//  dam-project
//
//  Created by m1 on 02/03/2022.
//

import Foundation

public class IngredientListSearch: Equatable{
    private var regex: String
    private var id: Int
    private var category: Int
    
    init(){
        self.regex = ""
        self.id = -1
        self.category = -1
    }
    
    public func setCategory(cat: Int){
        self.category = cat
    }
    
    public func setSearch(search: String){
        if let num = Int(search){
            self.id = num
            self.regex = ""
        } else {
            self.regex = search
            self.id = -1
        }
    }
    
    public func searchIngredients(ingredients: [Ingredient]) -> [Ingredient]{
        if self.id == -1 && self.regex == ""{
            return sortByCategory(ingredients: ingredients)
        } else if self.id != -1 {
            return sortById(ingredients: ingredients)
        } else {
            return sortByRegex(ingredients: ingredients)
        }
    }
    
    private func sortByCategory(ingredients: [Ingredient]) -> [Ingredient]{
        let result = ingredients.filter({ i in
            switch self.category{
            case 0:
                return i.code >= 100 && i.code <= 199
            case 1:
                return i.code >= 200 && i.code <= 299
            case 2:
                return i.code >= 300 && i.code <= 399
            case 3:
                return i.code >= 400 && i.code <= 499
            case 4:
                return i.code >= 500 && i.code <= 10000
            default:
                return true
            }
        })
        return result
    }
    
    private func sortById(ingredients: [Ingredient]) -> [Ingredient]{
        var result = sortByCategory(ingredients: ingredients)
        result = result.filter({ i in
            return i.code == self.id
        })
        return result
    }
    
    private func sortByRegex(ingredients: [Ingredient]) -> [Ingredient]{
        var result = sortByCategory(ingredients: ingredients)
        result = result.filter({ i in
            return i.libelle.lowercased().contains(self.regex.lowercased())
        })
        return result
    }
    
    public static func == (lhs: IngredientListSearch, rhs: IngredientListSearch) -> Bool {
        return lhs.id == rhs.id && lhs.regex == rhs.regex && lhs.category == rhs.category
    }
}
