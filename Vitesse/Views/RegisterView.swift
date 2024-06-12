//
//  RegisterView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 04/06/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: RegisterViewModel
    @EnvironmentObject var vstate: VState
    
    @State private var isOkForNewDestination: Bool = false
    @State private var p1: String = ""
    @State private var p2: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    VTitleText(text: "Register")
                    
                    // ? groups are used for avoid the limit of 10 views in a stack
                    Group {
                        VTextField(title: "Email", text: $viewModel.email, error: vstate.error)
                            .keyboardType(.emailAddress)
                        
                        VTextField(title: "First Name", text: $viewModel.firstName, error: vstate.error)
                        
                        VTextField(title: "LastName", text: $viewModel.lastName, error: vstate.error)
                    }
                    
                    Group {

                        
                        VTextField(title: "Password", text: $p1, isSecure: true, error: vstate.error)
                            .textContentType(.newPassword)
                        
                        VTextField(title: "Confirm Password", text: $p2, isSecure: true, error: vstate.error)
                            .textContentType(.newPassword)
                    }
                    
                    if vstate.error != .No {
                        VTextError(text: vstate.error.message)
                    }
                    
                    VButton(action: {
                        if viewModel.allInformationsAreValid(vstate: vstate) {
                            // in progress
                            //viewModel.register(vstate: vstate)
                            isOkForNewDestination = true
                        }
                    }, title: "Create")
                    .padding(.top, 30)
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
            }
            .onTapGesture {
                //            self.endEditing(true)  // This will dismiss the keyboard when tapping outside
            }
            .navigationDestination(isPresented: $isOkForNewDestination) {
                LoginView(viewModel: LoginViewModel())
            }
        }
    }
}



#Preview {
    RegisterView(viewModel: RegisterViewModel())
        .environmentObject(VState())
}
