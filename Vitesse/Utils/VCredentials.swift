//
//  VitesseCredentials.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import Foundation



// Structures de données compatibles JSON
struct VCredentials: Codable {
    let email: String
    let password: String
}
