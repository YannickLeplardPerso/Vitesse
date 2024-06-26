//
//  CandidateEditViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 25/06/2024.
//

import Foundation



class CandidateEditViewModel: ObservableObject {
    @Published var candidateEditInformations = VCandidateEditInformations(email: "", phone: "", linkedinURL: "", note: "")
    private var apiService = VAPIService()
    
    //func allInformationsAreValid(informations: VCandidateEditInformations, vstate: VState) -> Bool {
    func allInformationsAreValid(vstate: VState) -> Bool {
        // email
        if !VCheck.validEmail(candidateEditInformations.email) {
            vstate.error = .InvalidEmail
            return false
        }
        // phone
        if !VCheck.validFrenchPhoneNumber(candidateEditInformations.phone) {
            vstate.error = .InvalidPhoneNumber
            return false
        }
        // linkedIn
        if !candidateEditInformations.linkedinURL.isEmpty && !VCheck.validLinkedinURL(candidateEditInformations.linkedinURL) {
            vstate.error = .InvalidLinkedInURL
            return false
        }

        return true
    }
    
    @MainActor
    func updateInformations(candidate: VCandidate, vstate: VState) async {
        do {
            print(candidateEditInformations.linkedinURL)
            
            let informations = VCandidateInformations(firstName: candidate.firstName, lastName: candidate.lastName, editInformations: candidateEditInformations)
            
            print(informations.linkedinURL ?? "url linkedIn ??????")
            
            let candidup = try await apiService.askForUpdateCandidate(for: candidate.id, with: informations, from: vstate.token)
            
            if let index = vstate.candidates.firstIndex(where: { $0.id == candidate.id }) {
                vstate.candidates[index].email = candidup.email
                vstate.candidates[index].phone = candidup.phone
                print(candidup.linkedinURL ?? "linkedIn URL ????")
                vstate.candidates[index].linkedinURL = candidup.linkedinURL
                vstate.candidates[index].note = candidup.note
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

