//
//  VitesseError.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import Foundation

enum VError: Error {
    case No
    case GenericError
    case RequestDefault
    case RequestResponse
    case InvalidEmail
    case InvalidPhoneNumber
    case InvalidLinkedInURL
    case Empty
    case PasswordsDoNotMatch
    case InvalidName
    case Unauthorized
    // from URLError
    case CantConnectHost
    case GenericURLError

}

extension VError {
    var message: String {
        switch self {
        case .RequestResponse:
            return "Error request response."
        case .RequestDefault:
            return "Request error."
        case .InvalidEmail:
            return "Invalid email address."
        case .InvalidPhoneNumber:
            return "Invalid phone number."
        case .InvalidLinkedInURL:
            return "Invalid LinkedIn URL."
        case .Empty:
            return "All the fields must be filled."
        case .InvalidName:
            return "Names must contain only letters."
        case .Unauthorized:
            return "Access denied"
        case .PasswordsDoNotMatch:
            return "Passwords do not match."
        case .CantConnectHost:
            return "Cannot connect to Host."
        case .GenericURLError:
            return "Unknown URLError"
        case .GenericError:
            return "Unknown Error"
        case .No:
            return ""
        }
    }
}
