//
//  MockURLSession.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/07/2024.
//

import Foundation
import XCTest
@testable import Vitesse

class MockURLSession: NetworkSession {
    private let data: Data?
    private let response: URLResponse?
    private let error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
