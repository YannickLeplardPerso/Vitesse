//
//  CandidatesListView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI

struct CandidatesListView: View {
    @ObservedObject var viewModel: CandidatesListViewModel
    
    let candidates = MockCandidatesList().all
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // fonction d'édition
                }) {
                    Text("Edit")
                }
                
                Spacer()
                
                Text("Candidates")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    // affiche uniquement les favoris
                }) {
                    Image(systemName: "star")
                }
            }
            .padding()
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $viewModel.research)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            List(candidates) { candidate in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(candidate.firstName) \(candidate.lastName)")
                            .foregroundStyle(.cyan)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                        .foregroundColor(candidate.isFavorite ? .cyan : .gray)
                }
            }
        }
    }
}

#Preview {
    CandidatesListView(viewModel: CandidatesListViewModel())
}
