//
//  CandidateView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI

struct CandidateView: View {
    let candidates = MockCandidatesList().all
    
    var body: some View {
        let theCandidate = candidates[0]
        
        VStack {
            // todo : transformer "vraie" ligne de navigation
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "arrow.backward")
                }
                
                Spacer()
                
                Button(action: {
                    // fonction d'édition
                }) {
                    Text("Edit")
                }
            }
            .padding()
            
            HStack {
                Text("\(theCandidate.firstName) \(theCandidate.lastName)")
                    .font(.title)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    // pour modifier l'état de favori
                }) {
                    Image(systemName: theCandidate.isFavorite ? "star.fill" : "star")
                }
                // todo : si pas auth admin, bouton désactivé
                .disabled(false)
            }
            .padding()
            
            HStack {
                Text("Phone")
                Text(theCandidate.phone)
                    .font(.title3)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                    
                Spacer()
            }
            .padding()
            
            HStack {
                Text("Email")
                Text(theCandidate.email)
                    .font(.title3)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                    
                Spacer()
            }
            .padding()
            
            HStack {
                Text("LinkedIn")
                if let urlString = theCandidate.linkedinURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                   let url = URL(string: urlString) {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        Text("Go on LinkedIn")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.cyan.opacity(0.4))
                            .cornerRadius(8)
                            
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
            //.padding()
            
            if theCandidate.note != nil {
                Text(theCandidate.note ?? "")
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
}

#Preview {
    CandidateView()
}
