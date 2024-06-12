//
//  VitesseNewUserInformations.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 11/06/2024.
//

import Foundation



// Structures de données compatibles JSON
struct VNewUserInformations: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}
