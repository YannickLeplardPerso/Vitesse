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
    
    func login(vstate: VState) {
        Task{ @MainActor in
            do{
                // "admin@vitesse.com", "test123"
                let token = try await apiService.askForToken(for: VCredentials(email: email, password: password))
                vstate.token = token.token
                vstate.isAdmin = token.isAdmin
            } catch let urlError as URLError {
                switch urlError.code {
                case .cannotConnectToHost:
                    vstate.error = .CantConnectHost
                default:
                    vstate.error = .GenericURLError
                }
            } catch {
                vstate.error = .RequestResponse
            }
        }
    }
}
