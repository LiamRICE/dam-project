//
//  IngredientList.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public class IngredientList{
    var ingredientList: [Ingredient]
    
    func loadData() async {
        self.ingredientList = await DataDAO.getIngredientList()
        await DataDAO.getTechnicaldocList()
    }
    
    init(list: [Ingredient]){
        self.ingredientList = list
    }
    
    init(){
        self.ingredientList = []
    }
}
