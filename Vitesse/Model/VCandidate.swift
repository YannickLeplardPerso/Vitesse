//
//  Candidate.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



struct VCandidate: Identifiable, Codable, Hashable {
    let id: String
    let firstName: String
    let lastName: String
    var email: String
    var phone: String
    var isFavorite: Bool
    var linkedinURL: String?
    var note: String?
}

struct VCandidateInformations: Codable {
    let firstName: String
    let lastName: String
    var email: String
    var phone: String
    var linkedinURL: String?
    var note: String?
    
    init(firstName: String, lastName: String, editInformations: VCandidateEditInformations) {
            self.firstName = firstName
            self.lastName = lastName
            self.email = editInformations.email
            self.phone = editInformations.phone
            self.linkedinURL = editInformations.linkedinURL.isEmpty ? nil : editInformations.linkedinURL
            self.note = editInformations.note.isEmpty ? nil : editInformations.note
        }
}

struct VCandidateEditInformations: Codable {
    var email: String
    var phone: String
    var linkedinURL: String
    var note: String
}

