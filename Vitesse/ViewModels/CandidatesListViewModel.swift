//
//  CandidatesListViewModel.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import Foundation



class CandidatesListViewModel: ObservableObject {
    @Published var research: String = ""
    //@Published var candidates = [VCandidate]()
    
    private var apiService = VAPIService()
    
//    func candidatesList(vstate: VState) async {
//        do {
//            print("1 candidates")
//            vstate.candidates = try await apiService.askForCandidatesList(from: vstate.token)
//            print("2 candidates")
//        }
//        catch let urlError as URLError {
//            switch urlError.code {
//            case .cannotConnectToHost:
//                vstate.error = .CantConnectHost
//            default:
//                vstate.error = .GenericURLError
//            }
//        } catch let error as VError {
//            vstate.error = error
//        } catch {
//            vstate.error = .GenericError
//        }
//    }
}
