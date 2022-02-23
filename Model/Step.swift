//
//  Step.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import Foundation

public class Step: Equatable{
    
    var id: Int
    var title: String
    var description: String
    var time: Int
    var rank: Int
    var ingredients: [StepIngredient]
    
    init(id: Int, title: String, desc: String, time: Int, rk: Int, ingredients: [StepIngredient]){
        self.id = id
        self.title = title
        self.description = desc
        self.time = time
        self.rank = rk
        self.ingredients = ingredients
    }
    
    init(){
        self.id = -1
        self.title = "title"
        self.description = "description"
        self.time = 0
        self.rank = 0
        self.ingredients = []
    }
    
    public static func == (lhs: Step, rhs: Step) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func isEqual(_ other: Step) -> Bool{
        return self.id == other.id && self.title == other.title && self.description == other.description && self.time == other.time && self.rank ==  other.rank
    }
}
