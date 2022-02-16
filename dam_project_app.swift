//
//  dam_projectApp.swift
//  dam-project
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

@main
struct dam_project_app: App {
    
    @StateObject var ingredientListVM: IngredientListVM = IngredientListVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ingredientListVM)
        }
    }
}