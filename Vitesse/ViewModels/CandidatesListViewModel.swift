//
//  CandidatesListViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



class CandidatesListViewModel: ObservableObject {
    @Published var research: String = ""
    
    private var apiService = VAPIService()
    
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
    
    @MainActor
    func deleteCandidate(candidate: VCandidate, vstate: VState) async {
        do {
            try await apiService.askForDeleteCandidate(for: candidate.id, from: vstate.token)
        }
        catch let urlError as URLError {
            switch urlError.code {
            case .cannotConnectToHost:
                vstate.error = .CantConnectHost
            default:
                vstate.error = .GenericURLError
            }
        } catch let error as VError {
            vstate.error = error
        } catch {
            vstate.error = .GenericError
        }
    }
}
