//
//  IngredientView.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct IngredientView: View {
    var ingredient: Ingredient
    
    var body: some View {
        VStack{
            Text("Code: \(String(ingredient.code))")
            Text("Libelle: \(ingredient.libelle)")
            Text("Unité: \(ingredient.unit)")
            Text("Prix unitaire: \(ingredient.unitprice)")
            Text("Stocks: \(ingredient.stocks)")
            Text("Valeur du stock: \(ingredient.stockvalue)")
            Text("Allergène: \(ingredient.allergene)")
        }
    }
    
    init(ingredient: Ingredient){
        self.ingredient = ingredient
    }
}
/*
struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}
*/
