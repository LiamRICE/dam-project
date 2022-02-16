//
//  IngredientList.swift
//  dam-project
//
//  Created by Liam RICE on 16/02/2022.
//

import Foundation

public class IngredientList{
    var ingredientList: [Ingredient]
    
    init(list: [Ingredient]){
        self.ingredientList = list
    }
    
    init(){
        self.ingredientList = []
        if let fileURL = Bundle.main.url(forResource: "ingredients", withExtension: "json"){
            if let data = try? Data(contentsOf: fileURL){
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([Ingredient].self, from: data){
                    self.ingredientList = decoded
                }else{
                    print("error decoding data")
                }
            }else{
                print("error reading contents")
            }
        }else{
            print("error finding fileURL")
        }
    }
}
