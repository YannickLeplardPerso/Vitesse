//
//  MockCandidatesList.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation


struct MockCandidatesList {
    var all: [Candidate] =
    [ Candidate(id: "id_001", firstName: "Bruce", lastName: "Dickinson", email: "numberofthebeast@gmail.com", phone: "0666666666", isFavorite: true, linkedinURL: nil, note: nil),
      Candidate(id: "id_002", firstName: "James", lastName: "Hetfield", email: "metallica@gmail.com", phone: "0612345678", isFavorite: false, linkedinURL: nil, note: nil),
      Candidate(id: "id_003", firstName: "Steven", lastName: "Tyler", email: "aero@gmail.com", phone: "0687654321", isFavorite: false, linkedinURL: nil, note: nil)
    ]
}
