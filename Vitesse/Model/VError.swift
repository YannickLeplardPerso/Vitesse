//
//  VitesseError.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import Foundation

enum VError: Error {
    case No
    case RequestResponse
    case InvalidEmail
    case Empty
    case PasswordsDoNotMatch
    case InvalidName
// from URLError
    case CantConnectHost
    case GenericURLError
//    case AuthenticationDenied
}

extension VError {
    var message: String {
        switch self {
        case .RequestResponse:
            return "Request error."
        case .InvalidEmail:
            return "Invalid email address."
        case .Empty:
            return "All the fields must be filled."
        case .InvalidName:
            return "Names must contain only letters."
        case .PasswordsDoNotMatch:
            return "Passwords do not match."
        case .CantConnectHost:
            return "Cannot connect to Host."
        case .GenericURLError:
            return "Unknown URL Error"
        case .No:
            return ""
        }
    }
}
