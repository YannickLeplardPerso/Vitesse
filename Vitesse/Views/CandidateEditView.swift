//
//  CandidateEditView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import SwiftUI

struct CandidateEditView: View {
    @ObservedObject var viewModel: CandidateViewModel
    
    var body: some View {
        
        VStack {
            // todo : transformer "vraie" ligne de navigation
            HStack {
                Button(action: {
                    // fonction retour avec annulation des changements
                }) {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button(action: {
                    // fonction retour avec enregistrement des changements
                }) {
                    Text("Done")
                }
            }
            .padding(.bottom, 20)
            
            HStack {
                Text("\(viewModel.candidate.firstName) \(viewModel.candidate.lastName)")
                    .font(.title)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.bottom)
            
            VStack {
                Text("Phone")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Phone", text: $viewModel.candidate.phone)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .font(.title3)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)
            }
            
            VStack {
                Text("Email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Phone", text: $viewModel.candidate.email)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .font(.title3)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)
            }
            
            VStack {
                Text("LinkedIn")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("LinkedIn", text: Binding(
                    get: { viewModel.candidate.linkedinURL ?? "" },
                    set: { viewModel.candidate.linkedinURL = $0.isEmpty ? nil : $0 }))
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .font(.title3)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)
            }
            
            VStack {
                Text("Note")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextEditor(text: Binding(
                    get: { viewModel.candidate.note ?? "" },
                    set: { viewModel.candidate.note = $0.isEmpty ? nil : $0 }))
                    .padding()
                    //.frame(minHeight: 100)
                    .background(Color(UIColor.secondarySystemBackground))
                    .font(.title3)
                    .foregroundStyle(.cyan)
                    .fontWeight(.semibold)
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    CandidateEditView(viewModel: CandidateViewModel())
}
