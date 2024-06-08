//
//  CandidatesListView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI

struct CandidatesListView: View {
    
    let candidates = MockCandidatesList().all
    
    var body: some View {
        VStack {
            // todo : ligne Edit Candidates Star
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
                
                Image(systemName: "star")
            }
            .padding()
            // todo ligne research avec loupe dans champ à gauche
            
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
                //.padding(.vertical, 5)
//                .frame(maxWidth: .infinity) // Ensure the HStack spans the full width
//                                .background(
//                                    LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .leading, endPoint: .trailing)
//                                )
            }
            .listRowInsets(EdgeInsets())
            //.background(Color.cyan)
        }
        //.background(Color.cyan)
    }
}

#Preview {
    CandidatesListView()
}
