//
//  Candidate.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



struct VCandidate: Identifiable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    var email: String
    var phone: String
    let isFavorite: Bool
    var linkedinURL: String?
    var note: String?
}
