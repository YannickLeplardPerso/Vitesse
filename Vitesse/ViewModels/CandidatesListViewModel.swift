//
//  CandidatesListViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



class CandidatesListViewModel: ObservableObject {
    @Published var research: String = ""
    
    func filter(showOnlyFavorites: Bool, candidates: [VCandidate]) -> [VCandidate] {
        var filteredCandidates = candidates
        
        if !research.isEmpty {
            filteredCandidates = candidates.filter { candidate in
                        candidate.firstName.lowercased().contains(research.lowercased()) ||
                        candidate.lastName.lowercased().contains(research.lowercased())
                    }
                }
        
        if showOnlyFavorites {
            filteredCandidates = filteredCandidates.filter { $0.isFavorite }
        }
            
        return filteredCandidates
    }
}
