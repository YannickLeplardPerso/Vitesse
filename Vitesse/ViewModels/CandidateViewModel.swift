//
//  CandidateViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



class CandidateViewModel: ObservableObject {
    @Published var candidate: VCandidate = MockCandidatesList().all.first!
}
