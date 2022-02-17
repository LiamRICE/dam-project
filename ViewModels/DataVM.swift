//
//  DataVM.swift
//  dam-project
//
//  Created by m1 on 17/02/2022.
//

import Foundation

public class DataVM{
    @Published var dataState: LoadingIntent = .ready{
        didSet{
            switch self.dataState{
            case .loadingIngredients:
                self.dataState = .loadedIngredients
            case .loadingDocuments:
                self.dataState = .loadedDocuments
            default:
                return
            }
        }
    }
}
