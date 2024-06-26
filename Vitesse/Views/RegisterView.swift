//
//  RegisterView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 04/06/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @EnvironmentObject var vstate: VState
    
    @State private var isOkForNewDestination: Bool = false
    @State private var showingPopover = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    VTitleText(text: "Register")
                    
                    VTextField(title: "Email", text: $viewModel.email, error: $vstate.error)
                    
                    VTextField(title: "First Name", text: $viewModel.firstName, error: $vstate.error)
                    
                    VTextField(title: "LastName", text: $viewModel.lastName, error: $vstate.error)
                    
                    VTextField(title: "Password", text: $viewModel.newPassword, error: $vstate.error, isSecure: true)
                    
                    VTextField(title: "Confirm Password", text: $viewModel.confirmNewPassword, error: $vstate.error, isSecure: true)
                    
                    if vstate.error != .No {
                        VTextError(text: vstate.error.message)
                    }
                    
                    VButton(action: {
                        if viewModel.allInformationsAreValid(vstate: vstate) {
                            Task { @MainActor in
                                await viewModel.register(vstate: vstate)
                                if vstate.error == .No {
                                    showingPopover = true
                                }
                            }
                        }
                    }, title: "Create")
                    .padding(.top, 30)
                    .popover(isPresented: $showingPopover) {
                        VStack {
                            Text("Utilisateur \(viewModel.firstName) \(viewModel.lastName) enregistré")
                                .font(.headline)
                                .foregroundColor(.green)
                                .padding()
                            Button("OK") {
                                showingPopover = false
                                isOkForNewDestination = true
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
            }
            .navigationDestination(isPresented: $isOkForNewDestination) {
                LoginView(viewModel: LoginViewModel())
                    .navigationBarBackButtonHidden(true) 
            }
        }
    }
}



#Preview {
    RegisterView(viewModel: RegisterViewModel())
        .environmentObject(VState())
}
