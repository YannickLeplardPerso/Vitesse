//
//  CandidateEditView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import SwiftUI

struct CandidateEditView: View {
    let candidate: VCandidate
    @StateObject var viewModel = CandidateEditViewModel()
    @EnvironmentObject var vstate: VState
    
    @Environment(\.dismiss) var dismiss
    
//    init(candidate: VCandidate) {
//        self.candidate = candidate
//        viewModel.candidateEditInformations = VCandidateEditInformations(
//            email: candidate.email,
//            phone: candidate.phone,
//            linkedInURL: candidate.linkedInURL ?? "",
//            note: candidate.note ?? ""
//        )
//    }
        
    var body: some View {
        NavigationStack {
            VStack {
                if vstate.error != .No {
                    VTextError(text: vstate.error.message)
                }
                
                HStack {
                    VText(text: "\(candidate.firstName) \(candidate.lastName)")
                    Spacer()
                }
                .padding(.vertical)
                
                VStack {
                    VTextField(title: "Phone", text: $viewModel.candidateEditInformations.phone, error: $vstate.error)
                    VTextField(title: "Email", text: $viewModel.candidateEditInformations.email, error: $vstate.error)
                    VTextField(title: "LinkedIn", text: $viewModel.candidateEditInformations.linkedinURL, error: $vstate.error)
                    
                    VLabelText(text: "Note")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    TextEditor(text: $viewModel.candidateEditInformations.note)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .background(.quaternary)
                        .cornerRadius(8)
                        .frame(height: 200)
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if viewModel.allInformationsAreValid(vstate: vstate) {
                        }
                        Task { @MainActor in
                            await viewModel.updateInformations(candidate: candidate, vstate: vstate)
                            if vstate.error == .No {
                                dismiss()
                            }
                        }
                    }) {
                        Text("Done")
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
        .padding(.horizontal)
        .onAppear() {
            viewModel.candidateEditInformations = VCandidateEditInformations(
                email: candidate.email,
                phone: candidate.phone,
                linkedinURL: candidate.linkedinURL ?? "",
                note: candidate.note ?? ""
            )
        }
    }
}

#Preview {
    CandidateEditView(candidate:  MockCandidatesList().all.first!)
        .environmentObject(VState())
}
