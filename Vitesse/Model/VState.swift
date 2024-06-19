//
//  VitesseState.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import Foundation
import Combine



class VState: ObservableObject {
    //@Published var token = VToken(token: "", isAdmin: false)
    @Published var token: String = ""
    @Published var isAdmin: Bool = false
    @Published var error: VError = .No
    
    @Published var candidates = [VCandidate]()
}

