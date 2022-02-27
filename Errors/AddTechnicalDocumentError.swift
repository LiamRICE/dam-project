//
//  AddTechnicalDocumentError.swift
//  dam-project
//
//  Created by m1 on 27/02/2022.
//

import Foundation

public enum AddTechnicalDocumentError: String{
    case duplicateError = "Il existe déjà une fiche avec cet identifiant, essayez un autre."
    case incompleteError = "Il manque des informations. Complétez bien la fiche avant de valider."
    case unknownError = "Erreur inconnue."
}
