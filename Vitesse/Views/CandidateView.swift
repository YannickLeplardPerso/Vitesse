//
//  CandidateView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI

struct CandidateView: View {
    let candidate: VCandidate
    @ObservedObject var viewModel: CandidateViewModel
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
                    Text("\(candidate.firstName) \(candidate.lastName)")
                        .font(.title2)
                        .foregroundStyle(.cyan)
                        .fontWeight(.semibold)
                    
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
                    Text("Phone")
                    Text(candidate.phone)
                        .foregroundStyle(.cyan)
                        .fontWeight(.semibold)
                        
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Email")
                    Text(candidate.email)
                        .foregroundStyle(.cyan)
                        .fontWeight(.semibold)
                        
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("LinkedIn")
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
                    Text("Note")
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                if candidate.note != nil {
                    Text(candidate.note ?? "")
                        .font(.title3)
                        .foregroundStyle(.cyan)
                        .fontWeight(.semibold)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                        .padding()
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
            trailing: NavigationLink(destination: CandidateEditView()) {
                Text("Edit")
            }
        )
        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    Image(systemName: "arrow.backward")
//                }
//            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    //todo : mode édition des informations du candidat
//                }) {
//                    Text("Edit")
//                }
//            }
//        }
//        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CandidateView(candidate:  MockCandidatesList().all.first!, viewModel: CandidateViewModel())
        .environmentObject(VState())
}
