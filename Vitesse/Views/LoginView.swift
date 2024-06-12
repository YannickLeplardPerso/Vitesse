//
//  LoginView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 04/06/2024.
//

import SwiftUI



struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var vstate: VState
    
    @State private var isOkForNewDestination: Bool = false
    @State private var destination: VDestination = .No
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.viGradientTop, .viGradientBottom]), startPoint: .top, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {                    
                    VTitleText(text: "Login")
                    
                    VTextField(title: "Email", text: $viewModel.email, error: vstate.error)
                        .keyboardType(.emailAddress)
                    
                    VTextField(title: "Password", text: $viewModel.password, isSecure: true, error: vstate.error)
                    Text("Forgot password ?")
                        .foregroundColor(.viLightText)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, -12)
                    
                    if vstate.error != .No {
                        VTextError(text: vstate.error.message)
                    }
                    
                    VButton(action: {
                        if viewModel.emailAndPasswordAreValid(vstate: vstate) {
                            viewModel.login(vstate: vstate)
                            if vstate.token != "" {
                                navigate(to: .CandidatesList)
                            }
                        }
                    }, title: "Sign in")
                    .padding(.top, 30)
                    
                    VButton(action: {
                        navigate(to: .Register)
                    }, title: "Register")
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
            }
//            .onTapGesture {
//                self.endEditing(true)
//            }
            .navigationDestination(isPresented: $isOkForNewDestination) {
                if destination == .CandidatesList {
                    CandidatesListView(viewModel: CandidatesListViewModel())
                } else if destination == .Register {
                    RegisterView(viewModel: RegisterViewModel())
                }
            }
        }
    }
    
    private func navigate(to destination: VDestination) {
        self.destination = destination
        self.isOkForNewDestination = true
        resetFields()
    }
    
    private func resetFields() {
        viewModel.email = ""
        viewModel.password = ""
        vstate.error = .No
    }
}



#Preview {
    LoginView(viewModel: LoginViewModel())
        .environmentObject(VState())
}
