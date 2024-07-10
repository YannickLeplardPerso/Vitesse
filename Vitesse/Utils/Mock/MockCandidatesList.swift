//
//  MockCandidatesList.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation


struct MockCandidatesList {
    var all: [VCandidate] =
    [ VCandidate(id: "id_001", firstName: "Bruce", lastName: "Dickinson", email: "numberofthebeast@gmail.com", phone: "0666666666", isFavorite: true, linkedinURL: "https://www.linkedin.com/in/leplard-yannick", note: "Ideoque fertur neminem aliquando ob haec vel similia poenae addictum oblato de more elogio revocari iussisse, quod inexorabiles quoque principes factitarunt. et exitiale hoc vitium, quod in aliis non numquam intepescit, in illo aetatis progressu effervescebat, obstinatum eius propositum accendente adulatorum cohorte."),
      VCandidate(id: "id_002", firstName: "James", lastName: "Hetfield", email: "metallica@gmail.com", phone: "0612345678", isFavorite: false, linkedinURL: nil, note: nil),
      VCandidate(id: "id_003", firstName: "Steven", lastName: "Tyler", email: "aero@gmail.com", phone: "0687654321", isFavorite: false, linkedinURL: nil, note: nil),
      VCandidate(id: "id_004", firstName: "Ozzy", lastName: "Osbourne", email: "princeofdarkness@gmail.com", phone: "0766666666", isFavorite: true, linkedinURL: nil, note: nil),
      VCandidate(id: "id_005", firstName: "Michael", lastName: "Kiske", email: "helloween@gmail.com", phone: "0604030905", isFavorite: true, linkedinURL: nil, note: nil)
    ]
}
