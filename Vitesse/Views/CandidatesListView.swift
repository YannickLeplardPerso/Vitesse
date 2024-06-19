//
//  CandidatesListView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI

struct CandidatesListView: View {
    @ObservedObject var viewModel: CandidatesListViewModel
    @EnvironmentObject var vstate: VState
        
    var body: some View {
        NavigationStack {
            VStack {
                // research field
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.viText)
                        TextField("Search", text: $viewModel.research)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            
                    }
                    .padding(.horizontal)
                }
                .border(.viText)
                .padding(.horizontal)
                
                let candidates = vstate.candidates
                List(candidates) { candidate in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(candidate.firstName) \(candidate.lastName)")
                                    .foregroundStyle(.viLightText)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                                .foregroundColor(candidate.isFavorite ? .viText : .viBackgroundField)
                        }
                    }
                
                Spacer()
                
            }
            //.navigationTitle("Candidates")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // fonction d'édition
                    }) {
                        Text("Edit")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Candidates")
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // affiche uniquement les favoris
                    }) {
                        Image(systemName: "star")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CandidatesListView(viewModel: CandidatesListViewModel())
        .environmentObject(VState())
}
