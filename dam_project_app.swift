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
    @StateObject var technicalDocumentListVM: TechnicalDocumentListVM = TechnicalDocumentListVM()
    @StateObject var ingredientVM: IngredientVM = IngredientVM()
    @StateObject var technicalDocumentVM: TechnicalDocumentVM = TechnicalDocumentVM()
    @StateObject var stepVM: StepVM = StepVM()
    @StateObject var stepIngredientVM: StepIngredientVM = StepIngredientVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ingredientListVM)
                .environmentObject(ingredientVM)
                .environmentObject(technicalDocumentListVM)
                .environmentObject(technicalDocumentVM)
                .environmentObject(stepIngredientVM)
                .environmentObject(stepVM)
                .task {
                    print("loading data...")
                    await ingredientListVM.loadModel()
                    await technicalDocumentListVM.loadModel()
                }
        }
    }
}
