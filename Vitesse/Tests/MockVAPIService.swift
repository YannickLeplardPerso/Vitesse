//
//  MockVAPIService.swift
//  VitesseTests
//
//  Created by Yannick LEPLARD on 10/07/2024.
//

import XCTest
@testable import Vitesse



class MockVAPIService: VAPIService {
    var shouldThrowURLError = false
    var shouldThrowVError = false
    var shouldThrowGenericError = false
    var errorType: URLError.Code?
    var vErrorType: VError?

    var mockedCandidate: VCandidate?

    override func askForToggleFavoriteStatus(for id: String, from token: String) async throws -> VCandidate {
        if shouldThrowURLError, let errorType = errorType {
            throw URLError(errorType)
        }
        if shouldThrowVError, let vErrorType = vErrorType {
            throw vErrorType
        }
        if shouldThrowGenericError {
            throw NSError(domain: "MockError", code: 0, userInfo: nil)
        }

        // Toggle the favorite status of the mocked candidate
        if var candidate = mockedCandidate {
            candidate.isFavorite.toggle()
            return candidate
        } else {
            throw VError.RequestResponse
        }
    }
}
