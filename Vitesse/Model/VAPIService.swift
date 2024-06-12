//
//  VitesseAPIService.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import Foundation



//struct AuraAccount: Codable {
//    var currentBalance = 0.0
//    var transactions = [AuraTransaction]()
//}


//==================================
// SERVICE API
//==================================
class VAPIService {
    static let BASE_URL = "http://127.0.0.1:8080"
    
    // API running test : request must return "It works!"
    func createIsRunningOkRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: VAPIService.BASE_URL)!)
        request.httpMethod = "GET"
        return request
    }
    // -> return TRUE if the service is running
    func isRunningOk() async throws -> Bool {
        let (data, _) = try await URLSession.shared.data(for: createIsRunningOkRequest())
        
        if String(decoding: data, as: UTF8.self) == "It works!" {
            return true
        }
        
        return false
    }
    
    // login
    func createTokenRequest(for id: VCredentials) throws -> URLRequest {
        let stringURL = VAPIService.BASE_URL + "/user/auth"
        var request = URLRequest(url: URL(string: stringURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try JSONEncoder().encode(id)
        request.httpBody = data
        return request
    }
    // <- parameters are credentials (email, password)
    // -> return token and a boolean to indicate that the user is admin
    func askForToken(for id: VCredentials) async throws -> VToken {
        let (data, response) = try await URLSession.shared
            .data(for: createTokenRequest(for: id))
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw VError.RequestResponse
        }
        let token = try JSONDecoder().decode(VToken.self, from: data)
        return token
    }
    
    // register a new user
    func createRegisterRequest(for userInformations: VNewUserInformations) throws -> URLRequest {
        let stringURL = VAPIService.BASE_URL + "/user/register"
        var request = URLRequest(url: URL(string: stringURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try JSONEncoder().encode(userInformations)
        request.httpBody = data
        return request
    }
    // <- parameters are new user informations (email, password, first name and last name)
    // -> return code = 201 if the new user is created
    func registerNewUser(for userInformations: VNewUserInformations) async throws {
        let (_, response) = try await URLSession.shared
            .data(for: createRegisterRequest(for: userInformations))
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw VError.RequestResponse
        }
    }
    
    
    
    
//
//    // pour obtenir le détail d'un compte
//    func createDetailedAccountRequest(from token: String) throws -> URLRequest {
//        let stringURL = AuraAPIService.BASE_URL + "/account"
//        var request = URLRequest(url: URL(string: stringURL)!)
//        request.httpMethod = "GET"
//        request.setValue(token, forHTTPHeaderField: "token")
//        return request
//    }
//    // <- prend un token en paramètre
//    // -> retourne le détail du compte associé au token
//    func askForDetailedAccount(from token: String) async throws -> AuraAccount {
//        let (data, response) = try await session.data(for: createDetailedAccountRequest(from: token))
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw AuraError.RequestResponse
//        }
//        let auraAccount = try JSONDecoder().decode(AuraAccount.self, from: data)
//        return auraAccount
//    }
//    
//    // pour demander un transfert d'argent : réponse vide, mais code http = 200 si demande acceptée
//    func createMoneyTransferRequest(from token: String, to auraTransferInfos: AuraTransferInfos ) throws -> URLRequest {
//        let stringURL = AuraAPIService.BASE_URL + "/account/transfer"
//        var request = URLRequest(url: URL(string: stringURL)!)
//        request.httpMethod = "POST"
//        request.setValue(token, forHTTPHeaderField: "token")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let data = try JSONEncoder().encode(auraTransferInfos)
//        request.httpBody = data
//        return request
//    }
//    // <- prend un token en paramètre (demandeur) et les informations du transfert (email ou téléphone du destinataire et montant du transfert)
//    // -> retourne true si la demande est acceptée
//    func askForMoneyTransfer(from token: String, to auraTransferInfos: AuraTransferInfos) async throws -> Bool {
//        let (_, response) = try await session.data(for: createMoneyTransferRequest(from: token, to: auraTransferInfos))
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw AuraError.RequestResponse
//        }
//        return true
//    }
}

