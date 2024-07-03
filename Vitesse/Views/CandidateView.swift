//
//  CandidateView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI

struct CandidateView: View {
    let candidate: VCandidate
    @StateObject var viewModel = CandidateViewModel()
    @EnvironmentObject var vstate: VState
    
    @State private var showSafari = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if vstate.error != .No {
                    VTextError(text: vstate.error.message)
                }
                
                HStack {
                    VText(text: "\(candidate.firstName) \(candidate.lastName)")

                    Spacer()
                    
                    Button(action: {
                        Task { @MainActor in
                            await viewModel.toggleFavoriteStatus(candidate: candidate, vstate: vstate)
                        }
                    }) {
                        Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                    }
                    .disabled(vstate.isAdmin ? false : true)
                }
                .padding()
                
                HStack {
                    VLabelText(text: "Phone ")
                    VSubText(text: candidate.phone)
                    Spacer()
                }
                .padding()
                
                HStack {
                    VLabelText(text: "Email ")
                    VSubText(text: candidate.email)
                    Spacer()
                }
                .padding()
                
                HStack {
                    VLabelText(text: "LinkedIn ")
                    
                    if let urlString = candidate.linkedinURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: urlString) {
                        Button(action: {
                            showSafari = true
                        }) {
                            Text("Go on LinkedIn")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.cyan.opacity(0.4))
                                .cornerRadius(8)
                                
                        }
                        .sheet(isPresented: $showSafari) {
                            SafariView(url: url)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
                HStack {
                    VLabelText(text: "Note ")
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                if candidate.note != nil {
                    VSubText(text: candidate.note ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding() // for text inside the rounded rectangle
                        .background(Color.white)
                        .cornerRadius(8)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                        .padding(.horizontal) // for the rounded rectangle
                }
                
                Spacer()
            }
        }
        .navigationBarItems(
            leading: Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.backward")
            },
            trailing: NavigationLink(destination: CandidateEditView(candidate: candidate)) {
                Text("Edit")
            }
        )
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CandidateView(candidate:  MockCandidatesList().all.first!, viewModel: CandidateViewModel())
        .environmentObject(VState())
}
