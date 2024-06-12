//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var newPassword: String = ""
    @Published var confirmNewPassword: String = ""
    
    private var apiService = VAPIService()
    
    func allInformationsAreValid(vstate: VState) -> Bool {
        // all the fields must be filled
        let fields = [email, firstName, lastName, newPassword, confirmNewPassword]
        if fields.contains(where: { $0.isEmpty }) {
            vstate.error = .Empty
            return false
        }
        // email
        if !VCheck.validEmail(email) {
            vstate.error = .InvalidEmail
            return false
        }
        // first name and last name
        if !VCheck.validName(firstName) || !VCheck.validName(lastName) {
            vstate.error = .InvalidName
            return false
        }
        
        // both passwords must be equal
        if newPassword != confirmNewPassword {
            vstate.error = .PasswordsDoNotMatch
            return false
        }
        
        return true
    }
    
    func register(vstate: VState) {
        Task{ @MainActor in
            do{
                try await apiService.registerNewUser(for: VNewUserInformations(email: email, password: newPassword, firstName: firstName, lastName: lastName))
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
