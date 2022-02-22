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
    @Published var search: String
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
                print("List State : changedIngredientList")
            case .addingIngredient(let ingredient):
                self.ingredientList.append(ingredient) // local add
                self.ingredientList.sort(by: {
                    i1, i2 in return i1.code < i2.code
                })
                self.model.ingredientList = self.ingredientList
                Task{await DataDAO.postIngredient(ingredient: ingredient)} // distant add
                self.ingredientListState = .addedIngredient(ingredient)
            default:
                return
            }
        }
    }
    
    init(){
        self.model = IngredientList()
        self.ingredientList = self.model.ingredientList
        self.search = ""
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
}
