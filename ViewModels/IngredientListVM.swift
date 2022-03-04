//
//  IngredientListVM.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation
import SwiftUI

public class IngredientListVM: ObservableObject{
    private var model: IngredientList
    @Published var category: Int
    @Published var regex: String
    @Published var ingredientList: [Ingredient]
    @Published var ingredientListState: IngredientListIntent = .ready{
        didSet{
            switch ingredientListState{
            case .changingIngredientList:
                self.ingredientList.sort(by: {
                    i1, i2 in return i1.code < i2.code
                })
                self.model.ingredientList = self.ingredientList
                self.ingredientListState = .changedIngredientList
            case .addingIngredient(let ingredient):
                self.ingredientList = self.model.ingredientList
                self.ingredientList.append(ingredient)
                self.ingredientList.sort(by: {
                    i1, i2 in return i1.code < i2.code
                })
                self.model.ingredientList = self.ingredientList
                Task{await DataDAO.postIngredient(ingredient: ingredient)} // distant add
                self.ingredientListState = .addedIngredient(ingredient)
            case .searchingIngredientList(let listSearch):
                self.ingredientList = listSearch.searchIngredients(ingredients: self.model.ingredientList)
                self.ingredientListState = .searchedIngredientList(listSearch)
            case .deletingIngredient(let ingredient):
                if let index = self.ingredientList.firstIndex(of: ingredient){
                    Task{await DataDAO.deleteIngredient(ingredient: ingredient)}
                    self.ingredientList.remove(at: index)
                    self.model.ingredientList = self.ingredientList
                    self.ingredientListState = .deletedIngredient(ingredient)
                } else {
                    self.ingredientListState = .deleteIngredientError
                }
            default:
                return
            }
        }
    }
    
    init(){
        self.model = IngredientList()
        self.ingredientList = self.model.ingredientList
        self.regex = ""
        self.category = -1
    }
    
    public func subset(searchValue: String) -> [Ingredient]{
        var ret: [Ingredient] = []
        for ingredient in self.ingredientList{
            if(ingredient.libelle.contains(searchValue)){
                ret.append(ingredient)
            }
        }
        return ret
    }
    
    public func loadModel() async {
        await self.model.loadData()
        self.ingredientList = self.model.ingredientList
    }
    
    func getUnusedCode() -> Int{
        var num: Int = 0
        for ingredient in self.model.ingredientList{
            if num <= ingredient.code{
                num = ingredient.code + 1
            }
        }
        return num
    }
}
