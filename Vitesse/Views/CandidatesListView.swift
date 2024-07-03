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
    
    @State private var isEditing = false
    @State private var selectedCandidates = Set<VCandidate>()
    
    
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
                //List(candidates, id: \.self, selection: $selectedCandidates) { candidate in
                List {
                    ForEach(candidates) { candidate in
                        ZStack {
                            NavigationLink(destination: CandidateView(candidate: candidate)) {
                                EmptyView()
                            }
                            HStack {
                                if isEditing {
                                    Image(systemName: selectedCandidates.contains(candidate) ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(.viBackground)
                                        .onTapGesture {
                                            if selectedCandidates.contains(candidate) {
                                                selectedCandidates.remove(candidate)
                                            } else {
                                                selectedCandidates.insert(candidate)
                                            }
                                        }
                                }
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
                        vstate.error = .No
                        isEditing.toggle()
                        if !isEditing {
                            selectedCandidates.removeAll()
                        }
                    }) {
                        Text(isEditing ? "Cancel" : "Edit")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Candidates")
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        vstate.error = .No
                        if isEditing {
                            Task {
                                for candidate in selectedCandidates {
                                    await viewModel.deleteCandidate(candidate: candidate, vstate: vstate)
                                    if vstate.error == .No, let index = vstate.candidates.firstIndex(where: { $0.id == candidate.id }) {
                                        vstate.candidates.remove(at: index)
                                    }
                                }
                                selectedCandidates.removeAll()
                                isEditing.toggle()
                            }
                        } else {
                            showOnlyFavorites.toggle()
                        }
                    }) {
                        if isEditing {
                            Text("Delete")
                        } else {
                            Image(systemName: showOnlyFavorites ? "star.fill" : "star")
                        }
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


//                List(candidates, id: \.self, selection: $selectedCandidates) { candidate in
//                    ZStack {

//                        HStack {
//                            if isEditing {
//                                Image(systemName: selectedCandidates.contains(candidate) ? "checkmark.circle.fill" : "circle")
//                                    .foregroundColor(.viBackground)
//                                    .onTapGesture {
//                                        if selectedCandidates.contains(candidate) {
//                                            selectedCandidates.remove(candidate)
//                                        } else {
//                                            selectedCandidates.insert(candidate)
//                                        }
//                                    }
//                            }
//                            Text("\(candidate.firstName) \(candidate.lastName)")
//                                .foregroundStyle(.viLightText)
//                                .fontWeight(.semibold)
//                            

//                    }
//                }
//                
//                Spacer()
//            }


#Preview {
    CandidatesListView(viewModel: CandidatesListViewModel())
        .environmentObject(VState())
}
