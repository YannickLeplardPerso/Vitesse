//
//  CandidatesListView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI



struct CandidatesListView: View {
    @StateObject var viewModel = CandidatesListViewModel()
    @EnvironmentObject var vstate: VState
    
    @State private var showOnlyFavorites = false
            
    var body: some View {
        NavigationStack {
            VStack {
                // research field
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.viText)
                        .padding()
                    TextField("Search", text: $viewModel.research)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                }
                .border(.viText)
                .padding(.horizontal)

                let candidates = viewModel.filter(showOnlyFavorites: showOnlyFavorites, candidates:  vstate.candidates)
                List {
                    ForEach(candidates) { candidate in
                        ZStack {
                            NavigationLink(destination: CandidateView(candidate: candidate)) {
                                EmptyView()
                            }
                            HStack {
                                Text("\(candidate.firstName) \(candidate.lastName)")
                                    .foregroundStyle(.viLightText)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                                    .foregroundColor(candidate.isFavorite ? .viText : .viBackgroundField)
                            }
                            .padding(.trailing, 20)
                        }
                    }
                }
                
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // delete candidate(s)
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
                        showOnlyFavorites.toggle()
                    }) {
                        Image(systemName: showOnlyFavorites ? "star.fill" : "star")
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
