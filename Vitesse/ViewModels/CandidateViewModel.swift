//
//  CandidateViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



class CandidateViewModel: ObservableObject {
    private var apiService = VAPIService()
    
    @MainActor
    func toggleFavoriteStatus(candidate: VCandidate, vstate: VState) async {
        do {
            let candidup = try await apiService.askForToggleFavoriteStatus(for: candidate.id, from: vstate.token)
            
            if let index = vstate.candidates.firstIndex(where: { $0.id == candidate.id }) {
                vstate.candidates[index].isFavorite = candidup.isFavorite
            }
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
