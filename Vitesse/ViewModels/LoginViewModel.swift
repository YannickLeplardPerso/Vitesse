//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var apiService = VAPIService()
    
    func emailAndPasswordAreValid(vstate: VState) -> Bool {
        // all the fields must be filled
        if email == "" || password == "" {
            vstate.error = .Empty
            return false
        }
        // if email address is invalid, we erase password field
        if !VCheck.validEmail(email) {
            password = ""
            vstate.error = .InvalidEmail
            return false
        }
        
        return true
    }
    
    @MainActor
    func login(vstate: VState) async {
        do {
            let vtoken = try await apiService.askForToken(for: VCredentials(email: email, password: password))
            vstate.token = vtoken.token
            vstate.isAdmin = vtoken.isAdmin
        } catch let urlError as URLError {
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
    
    @MainActor
    func candidatesList(vstate: VState) async {
        do {
            vstate.candidates = try await apiService.askForCandidatesList(from: vstate.token)
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
