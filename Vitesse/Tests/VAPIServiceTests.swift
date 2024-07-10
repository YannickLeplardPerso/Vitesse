//
//  VAPIServiceTests.swift
//  VitesseTests
//
//  Created by Yannick LEPLARD on 10/07/2024.
//

import XCTest
@testable import Vitesse



class VAPIServiceTests: XCTestCase {
    
    func testIsRunningOk() async throws {
        let expectedData = "It works!".data(using: .utf8)
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: expectedData, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        let isRunning = try await apiService.isRunningOk()
        
        XCTAssertTrue(isRunning)
    }
    
    func testIsRunningOk_KO() async throws {
        let expectedData: Data? = nil
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL)!, statusCode: 504, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: expectedData, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        let isRunning = try await apiService.isRunningOk()
        
        XCTAssertFalse(isRunning)
    }
    
    func testAskForToken_Success() async throws {
        let credentials = VCredentials(email: "test@example.com", password: "password")
        let expectedToken = VToken(token: "12345", isAdmin: true)
        let expectedData = try JSONEncoder().encode(expectedToken)
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/user/auth")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: expectedData, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        let token = try await apiService.askForToken(for: credentials)
        
        XCTAssertEqual(token.token, expectedToken.token)
        XCTAssertEqual(token.isAdmin, expectedToken.isAdmin)
    }
    
    func testAskForToken_Unauthorized() async throws {
        let credentials = VCredentials(email: "test@example.com", password: "notValidPassword")
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/user/auth")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForToken(for: credentials)
            XCTFail("Expected to throw VError.Unauthorized")
        } catch let error as VError {
            XCTAssertEqual(error, VError.Unauthorized)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForToken_BadResponse() async throws {
        let credentials = VCredentials(email: "test@example.com", password: "notValidPassword")
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/user/auth")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForToken(for: credentials)
            XCTFail("Expected to throw VError.RequestDefault")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestDefault)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForToken_NotHTTPURLResponse() async throws {
        let credentials = VCredentials(email: "test@example.com", password: "validPassword")
        let sessionMock = MockURLSession(data: nil, response: nil, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForToken(for: credentials)
            XCTFail("Expected to throw VError.RequestResponse")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRegisterNewUser_Success() async throws {
        let newUser = VNewUserInformations(
            email: "newuser@example.com",
            password: "password",
            firstName: "New",
            lastName: "User"
        )
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/user/register")!, statusCode: 201, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        try await apiService.registerNewUser(for: newUser)
        // If no error is thrown, the test passes
    }
    
    func testRegisterNewUser_Unauthorized() async throws {
        let newUser = VNewUserInformations(
            email: "test@example.com",
            password: "password",
            firstName: "John",
            lastName: "Doe"
        )
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/user/register")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            try await apiService.registerNewUser(for: newUser)
            XCTFail("Expected to throw VError.Unauthorized")
        } catch let error as VError {
            XCTAssertEqual(error, VError.Unauthorized)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRegisterNewUser_BadResponse() async throws {
        let newUser = VNewUserInformations(
            email: "test@example.com",
            password: "password",
            firstName: "John",
            lastName: "Doe"
        )
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/user/register")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        let apiService = VAPIService(session: sessionMock)
        
        do {
            try await apiService.registerNewUser(for: newUser)
            XCTFail("Expected to throw VError.RequestDefault")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestDefault)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRegisterNewUser_NotHTTPURLResponse() async throws {
        let newUser = VNewUserInformations(
            email: "test@example.com",
            password: "password",
            firstName: "John",
            lastName: "Doe"
        )
        let sessionMock = MockURLSession(data: nil, response: nil, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            try await apiService.registerNewUser(for: newUser)
            XCTFail("Expected to throw VError.RequestResponse")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForCandidatesList_Success() async throws {
        let token = "validToken"
        let candidates = [
            VCandidate(
                id: "1",
                firstName: "John",
                lastName: "Doe",
                email: "john.doe@example.com",
                phone: "1234567890",
                isFavorite: false,
                linkedinURL: "https://www.linkedin.com/in/johndoe",
                note: "Great candidate"
            ),
            VCandidate(
                id: "2",
                firstName: "Jane",
                lastName: "Smith",
                email: "jane.smith@example.com",
                phone: "0987654321",
                isFavorite: true,
                linkedinURL: "https://www.linkedin.com/in/janesmith",
                note: "Excellent candidate"
            )
        ]
        let expectedData = try JSONEncoder().encode(candidates)
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: expectedData, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        let result = try await apiService.askForCandidatesList(from: token)
        
        XCTAssertEqual(result.count, candidates.count)
        XCTAssertEqual(result[0].id, candidates[0].id)
        XCTAssertEqual(result[0].firstName, candidates[0].firstName)
        XCTAssertEqual(result[0].lastName, candidates[0].lastName)
        XCTAssertEqual(result[0].email, candidates[0].email)
        XCTAssertEqual(result[0].phone, candidates[0].phone)
        XCTAssertEqual(result[0].isFavorite, candidates[0].isFavorite)
        XCTAssertEqual(result[0].linkedinURL, candidates[0].linkedinURL)
        XCTAssertEqual(result[0].note, candidates[0].note)
        XCTAssertEqual(result[1].id, candidates[1].id)
        XCTAssertEqual(result[1].firstName, candidates[1].firstName)
        XCTAssertEqual(result[1].lastName, candidates[1].lastName)
        XCTAssertEqual(result[1].email, candidates[1].email)
        XCTAssertEqual(result[1].phone, candidates[1].phone)
        XCTAssertEqual(result[1].isFavorite, candidates[1].isFavorite)
        XCTAssertEqual(result[1].linkedinURL, candidates[1].linkedinURL)
        XCTAssertEqual(result[1].note, candidates[1].note)
    }
    
    func testAskForCandidatesList_Unauthorized() async throws {
        let token = "invalidToken"
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForCandidatesList(from: token)
            XCTFail("Expected to throw VError.Unauthorized")
        } catch let error as VError {
            XCTAssertEqual(error, VError.Unauthorized)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForCandidatesList_BadResponse() async throws {
        let token = "token"
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForCandidatesList(from: token)
            XCTFail("Expected to throw VError.RequestDefault")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestDefault)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForCandidatesList_NotHTTPURLResponse() async throws {
        let token = "token"
        let sessionMock = MockURLSession(data: nil, response: nil, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForCandidatesList(from: token)
            XCTFail("Expected to throw VError.RequestResponse")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForUpdateCandidate_Success() async throws {
        let token = "validToken"
        let candidateID = "1"
        let editInformations = VCandidateEditInformations(
            email: "john.doe@example.com",
            phone: "1234567890",
            linkedinURL: "https://www.linkedin.com/in/johndoe",
            note: "Great candidate"
        )
        let candidateInfo = VCandidateInformations(
            firstName: "John",
            lastName: "Doe",
            editInformations: editInformations
        )
        let updatedCandidate = VCandidate(
            id: candidateID,
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
            isFavorite: false,
            linkedinURL: "https://www.linkedin.com/in/johndoe",
            note: "Great candidate"
        )
        let expectedData = try JSONEncoder().encode(updatedCandidate)
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateID)")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: expectedData, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        let candidate = try await apiService.askForUpdateCandidate(for: candidateID, with: candidateInfo, from: token)
        
        XCTAssertEqual(candidate, updatedCandidate)
    }
    
    func testAskForUpdateCandidate_Unauthorized() async throws {
        let token = "invalidToken"
        let candidateID = "1"
        let editInformations = VCandidateEditInformations(
            email: "john.doe@example.com",
            phone: "1234567890",
            linkedinURL: "https://www.linkedin.com/in/johndoe",
            note: "Great candidate"
        )
        let candidateInfo = VCandidateInformations(
            firstName: "John",
            lastName: "Doe",
            editInformations: editInformations
        )
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateID)")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForUpdateCandidate(for: candidateID, with: candidateInfo, from: token)
            XCTFail("Expected to throw VError.Unauthorized")
        } catch let error as VError {
            XCTAssertEqual(error, VError.Unauthorized)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForUpdateCandidate_BadResponse() async throws {
        let token = "invalidToken"
        let candidateID = "1"
        let editInformations = VCandidateEditInformations(
            email: "john.doe@example.com",
            phone: "1234567890",
            linkedinURL: "https://www.linkedin.com/in/johndoe",
            note: "Great candidate"
        )
        let candidateInfo = VCandidateInformations(
            firstName: "John",
            lastName: "Doe",
            editInformations: editInformations
        )
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateID)")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForUpdateCandidate(for: candidateID, with: candidateInfo, from: token)
            XCTFail("Expected to throw VError.RequestDefault")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestDefault)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForUpdateCandidate_NotHTTPURLResponse() async throws {
        let token = "token"
        let candidateID = "1"
        let editInformations = VCandidateEditInformations(
            email: "john.doe@example.com",
            phone: "1234567890",
            linkedinURL: "https://www.linkedin.com/in/johndoe",
            note: "Great candidate"
        )
        let candidateInfo = VCandidateInformations(
            firstName: "John",
            lastName: "Doe",
            editInformations: editInformations
        )
        let sessionMock = MockURLSession(data: nil, response: nil, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForUpdateCandidate(for: candidateID, with: candidateInfo, from: token)
            XCTFail("Expected to throw VError.RequestResponse")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForDeleteCandidate_Success() async throws {
        let token = "validToken"
        let candidateId = "1"
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateId)")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        try await apiService.askForDeleteCandidate(for: candidateId, from: token)
        
        // If no error is thrown, the test passes
    }
    
    func testAskForDeleteCandidate_Unauthorized() async throws {
        let token = "invalidToken"
        let candidateId = "1"
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateId)")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            try await apiService.askForDeleteCandidate(for: candidateId, from: token)
            XCTFail("Expected to throw VError.Unauthorized")
        } catch let error as VError {
            XCTAssertEqual(error, VError.Unauthorized)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForDeleteCandidate_BadResponse() async throws {
        let token = "token"
        let candidateId = "1"
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateId)")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            try await apiService.askForDeleteCandidate(for: candidateId, from: token)
            XCTFail("Expected to throw VError.RequestDefault")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestDefault)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForDeleteCandidate_NotHTTPURLResponse() async throws {
        let token = "token"
        let candidateId = "1"
        let sessionMock = MockURLSession(data: nil, response: nil, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            try await apiService.askForDeleteCandidate(for: candidateId, from: token)
            XCTFail("Expected to throw VError.RequestResponse")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForToggleFavoriteStatus_Success() async throws {
        let token = "validToken"
        let candidateID = "1"
        
        // Create an expected updated candidate
        let toggledCandidate = VCandidate(
            id: candidateID,
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
            isFavorite: true, // Assuming the favorite status is toggled to true
            linkedinURL: "https://www.linkedin.com/in/johndoe",
            note: "Great candidate"
        )
        let expectedData = try JSONEncoder().encode(toggledCandidate)
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateID)/favorite")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: expectedData, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        let candidate = try await apiService.askForToggleFavoriteStatus(for: candidateID, from: token)
        
        XCTAssertEqual(candidate, toggledCandidate)
    }
    
    func testAskForToggleFavoriteStatus_Unauthorized() async throws {
        let token = "invalidToken"
        let candidateID = "1"
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateID)/favorite")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForToggleFavoriteStatus(for: candidateID, from: token)
            XCTFail("Expected to throw VError.Unauthorized")
        } catch let error as VError {
            XCTAssertEqual(error, VError.Unauthorized)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAskForToggleFavoriteStatus_BadResponse() async throws {
        let token = "token"
        let candidateID = "1"
        let urlResponse = HTTPURLResponse(url: URL(string: VAPIService.BASE_URL + "/candidate/\(candidateID)/favorite")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: nil, response: urlResponse, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForToggleFavoriteStatus(for: candidateID, from: token)
            XCTFail("Expected to throw VError.RequestDefault")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestDefault)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testAskForToggleFavoriteStatus_NotHTTPURLResponse() async throws {
        let token = "token"
        let candidateID = "1"
        let sessionMock = MockURLSession(data: nil, response: nil, error: nil)
        
        let apiService = VAPIService(session: sessionMock)
        
        do {
            _ = try await apiService.askForToggleFavoriteStatus(for: candidateID, from: token)
            XCTFail("Expected to throw VError.RequestResponse")
        } catch let error as VError {
            XCTAssertEqual(error, VError.RequestResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
