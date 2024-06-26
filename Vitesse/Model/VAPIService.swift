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
    
    private let session = URLSession.shared
    
    // API running test : request must return "It works!"
    func createIsRunningOkRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: VAPIService.BASE_URL)!)
        request.httpMethod = "GET"
        return request
    }
    // -> return TRUE if the service is running
    func isRunningOk() async throws -> Bool {
        let (data, _) = try await session.data(for: createIsRunningOkRequest())
        
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
        let (data, response) = try await session.data(for: createTokenRequest(for: id))
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw VError.RequestResponse
        }
        switch httpResponse.statusCode {
        case 200:
            let token = try JSONDecoder().decode(VToken.self, from: data)
            return token
        case 401:
            throw VError.Unauthorized
        default:
            throw VError.RequestDefault
        }
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
        let (_, response) = try await session.data(for: createRegisterRequest(for: userInformations))
        print(response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw VError.RequestResponse
        }
        switch httpResponse.statusCode {
        case 201:
            return
        case 401:
            throw VError.Unauthorized
        default:
            throw VError.RequestDefault
        }
    }
    
    // get the list of candidates
    func createCandidatesListRequest(from token: String) throws -> URLRequest {
        let stringURL = VAPIService.BASE_URL + "/candidate"
        var request = URLRequest(url: URL(string: stringURL)!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    // <- parameter is the token of the authenticated user
    // -> return the list of candidates
    func askForCandidatesList(from token: String) async throws -> [VCandidate] {
        let (data, response) = try await session.data(for: createCandidatesListRequest(from: token))
        guard let httpResponse = response as? HTTPURLResponse else {
            throw VError.RequestResponse
        }
        switch httpResponse.statusCode {
        case 200:
            let candidates = try JSONDecoder().decode([VCandidate].self, from: data)
            return candidates
        case 401:
            throw VError.Unauthorized
        default:
            throw VError.RequestDefault
        }
    }

    // get the detail of a candidate
//    func createCandidateRequest(for id: String, from token: String) throws -> URLRequest {
//        let stringURL = VAPIService.BASE_URL + "/candidate/" + id
//        var request = URLRequest(url: URL(string: stringURL)!)
//        request.httpMethod = "GET"
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        return request
//    }
    // <- parameters are id of the candidate and token
    // -> return detailed informations of the candidate
//    func askForCandidate(for id: String, from token: String) async throws -> [VCandidate] {
//        let (data, response) = try await session.data(for: createCandidateRequest(for: id, from: token))
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw VError.RequestResponse
//        }
//        switch httpResponse.statusCode {
//        case 200:
//            let candidates = try JSONDecoder().decode([VCandidate].self, from: data)
//            return candidates
//        case 401:
//            throw VError.Unauthorized
//        default:
//            throw VError.RequestDefault
//        }
//    }
    
    // create a new candidate
//    func createNewCandidateRequest(with informations: VCandidateInformations, from token: String) throws -> URLRequest {
//        let stringURL = VAPIService.BASE_URL + "/candidate/"
//        var request = URLRequest(url: URL(string: stringURL)!)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let data = try JSONEncoder().encode(informations)
//        request.httpBody = data
//        return request
//    }
    // <- parameters are informations of the candidate and token
    // -> return the candidate (VCandidate)
//    func askForUpdateCandidate(for id: String, with informations: VCandidateInformations, from token: String) async throws -> VCandidate {
//        let (data, response) = try await session.data(for: createNewCandidateRequest(with: informations, from: token))
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw VError.RequestResponse
//        }
//        switch httpResponse.statusCode {
//        case 200:
//            let candidate = try JSONDecoder().decode(VCandidate.self, from: data)
//            return candidate
//        case 401:
//            throw VError.Unauthorized
//        default:
//            throw VError.RequestDefault
//        }
//    }
    
    // update informations of a candidate
    func createUpdateCandidateRequest(for id: String, with informations: VCandidateInformations, from token: String) throws -> URLRequest {
        let stringURL = VAPIService.BASE_URL + "/candidate/" + id
        var request = URLRequest(url: URL(string: stringURL)!)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try JSONEncoder().encode(informations)
        request.httpBody = data
        return request
    }
    // <- parameters are id of the candidate, informations of the candidate and token
    // -> return the candidate (VCandidate) with new informations
    func askForUpdateCandidate(for id: String, with informations: VCandidateInformations, from token: String) async throws -> VCandidate {
        let (data, response) = try await session.data(for: createUpdateCandidateRequest(for: id, with: informations, from: token))
        guard let httpResponse = response as? HTTPURLResponse else {
            throw VError.RequestResponse
        }
        switch httpResponse.statusCode {
        case 200:
            let candidate = try JSONDecoder().decode(VCandidate.self, from: data)
            return candidate
        case 401:
            throw VError.Unauthorized
        default:
            throw VError.RequestDefault
        }
    }
    
    // delete a candidate
    func createDeleteCandidateRequest(for id: String, from token: String) throws -> URLRequest {
        let stringURL = VAPIService.BASE_URL + "/candidate/" + id
        var request = URLRequest(url: URL(string: stringURL)!)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    // <- parameters are id of the candidate and token
    // -> return 200 if delete is ok
    func askForDeleteCandidate(for id: String, from token: String) async throws {
        let (_, response) = try await session.data(for: createDeleteCandidateRequest(for: id, from: token))
        guard let httpResponse = response as? HTTPURLResponse else {
            throw VError.RequestResponse
        }
        switch httpResponse.statusCode {
        case 200:
            return
        case 401:
            throw VError.Unauthorized
        default:
            throw VError.RequestDefault
        }
    }
        
    // toggle favorite status of a candidate (admin only!)
    // !!! attention la doc API est fausse : c'est bien un POST et pas un PUT
    func createToggleFavoriteStatusRequest(for id: String, from token: String) throws -> URLRequest {
        let stringURL = VAPIService.BASE_URL + "/candidate/" + id + "/favorite"
        var request = URLRequest(url: URL(string: stringURL)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    // <- parameters are id of the candidate, informations of the candidate and token
    // -> return the candidate (VCandidate) with new informations
    func askForToggleFavoriteStatus(for id: String, from token: String) async throws -> VCandidate {
        let (data, response) = try await session.data(for: createToggleFavoriteStatusRequest(for: id, from: token))
        guard let httpResponse = response as? HTTPURLResponse else {
            throw VError.RequestResponse
        }
        switch httpResponse.statusCode {
        case 200:
            let candidate = try JSONDecoder().decode(VCandidate.self, from: data)
            return candidate
        case 401:
            throw VError.Unauthorized
        default:
            throw VError.RequestDefault
        }
    }
}

