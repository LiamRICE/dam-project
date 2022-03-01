//
//  AddIngredientToStepError.swift
//  dam-project
//
//  Created by m1 on 01/03/2022.
//

import Foundation

public enum AddIngredientToStepError: String{
    case duplicateError = "Il existe déjà cet ingrédient dans la liste, modifiez sa valeur au lieu de rajouter un doublon."
    case incompleteError = "Il manque des informations. Complétez bien toutes les entrées avant de valider."
    case unknownError = "Erreur inconnue."
}
