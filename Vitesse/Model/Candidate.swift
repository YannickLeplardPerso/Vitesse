//
//  Candidate.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



struct Candidate: Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var isFavorite: Bool
    var linkedinURL: String?
    var note: String?
}
