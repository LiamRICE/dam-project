//
//  Step.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import Foundation

public class Step{
    var id: Int
    var title: String
    var description: String
    var time: Int
    var rank: Int
    var ingredients: [Ingredient]
    
    init(id: Int, title: String, desc: String, time: Int, rk: Int, ingredients: [Ingredient]){
        self.id = id
        self.title = title
        self.description = desc
        self.time = time
        self.rank = rk
        self.ingredients = ingredients
    }
}
