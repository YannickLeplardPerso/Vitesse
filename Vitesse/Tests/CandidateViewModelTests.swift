//
//  CandidateViewModelTests.swift
//  VitesseTests
//
//  Created by Yannick LEPLARD on 10/07/2024.
//

import XCTest
@testable import Vitesse
import Combine



class CandidateViewModelTests: XCTestCase {
    
    func testToggleFavoriteStatus_Success() async throws {
        let mockAPIService = MockVAPIService()
        let viewModel = CandidateViewModel(apiService: mockAPIService)
        
        let candidate = VCandidate(
            id: "1",
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
            isFavorite: false,
            linkedinURL: nil,
            note: nil
        )
        
        let mockVState = VState()
        mockVState.token = "mockToken"
        mockVState.candidates = [candidate]
        mockAPIService.mockedCandidate = candidate
                
        await viewModel.toggleFavoriteStatus(candidate: candidate, vstate: mockVState)
        
        // Act
        await viewModel.toggleFavoriteStatus(candidate: candidate, vstate: mockVState)
        
        // Assert
        if let updatedCandidate = mockVState.candidates.first {
            XCTAssertEqual(updatedCandidate.isFavorite, !candidate.isFavorite)
        } else {
            XCTFail("Candidate not found in state after toggle")
        }
    }
    
    func testToggleFavoriteStatus_CannotConnectToHost() async throws {
        // Arrange
        let mockAPIService = MockVAPIService()
        mockAPIService.shouldThrowURLError = true
        mockAPIService.errorType = .cannotConnectToHost
        
        let viewModel = CandidateViewModel(apiService: mockAPIService)
        
        let candidate = VCandidate(id: "1", firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "1234567890", isFavorite: false, linkedinURL: nil, note: nil)
        
        let mockVState = VState()
        mockVState.candidates = [candidate]
        mockVState.token = "mockToken"
        
        // Act
        await viewModel.toggleFavoriteStatus(candidate: candidate, vstate: mockVState)
        
        // Assert
        XCTAssertEqual(mockVState.error, .CantConnectHost)
    }
    
    func testToggleFavoriteStatus_GenericURLError() async throws {
        // Arrange
        let mockAPIService = MockVAPIService()
        mockAPIService.shouldThrowURLError = true
        mockAPIService.errorType = .timedOut
        
        let viewModel = CandidateViewModel(apiService: mockAPIService)
        
        let candidate = VCandidate(id: "1", firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "1234567890", isFavorite: false, linkedinURL: nil, note: nil)
        
        let mockVState = VState()
        mockVState.candidates = [candidate]
        mockVState.token = "mockToken"
        
        // Act
        await viewModel.toggleFavoriteStatus(candidate: candidate, vstate: mockVState)
        
        // Assert
        XCTAssertEqual(mockVState.error, .GenericURLError)
    }
    
    func testToggleFavoriteStatus_VErrorUnauthorized() async throws {
        // Arrange
        let mockAPIService = MockVAPIService()
        mockAPIService.shouldThrowVError = true
        mockAPIService.vErrorType = .Unauthorized
        
        let viewModel = CandidateViewModel(apiService: mockAPIService)
        
        let candidate = VCandidate(id: "1", firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "1234567890", isFavorite: false, linkedinURL: nil, note: nil)
        
        let mockVState = VState()
        mockVState.candidates = [candidate]
        mockVState.token = "mockToken"
        
        // Act
        await viewModel.toggleFavoriteStatus(candidate: candidate, vstate: mockVState)
        
        // Assert
        XCTAssertEqual(mockVState.error, .Unauthorized)
    }
    
    func testToggleFavoriteStatus_GenericError() async throws {
        // Arrange
        let mockAPIService = MockVAPIService()
        mockAPIService.shouldThrowGenericError = true
        let viewModel = CandidateViewModel(apiService: mockAPIService)
        
        let candidate = VCandidate(id: "1", firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "1234567890", isFavorite: false, linkedinURL: nil, note: nil)
        
        let mockVState = VState()
        mockVState.candidates = [candidate]
        mockVState.token = "mockToken"
        
        // Act
        await viewModel.toggleFavoriteStatus(candidate: candidate, vstate: mockVState)
        
        // Assert
        XCTAssertEqual(mockVState.error, .GenericError)
    }
}
