//
//  LoginView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 04/06/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                Text("Email/Username")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                TextField("Adresse email", text: $viewModel.username)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)
                
                Text("Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                SecureField("Mot de passe", text: $viewModel.password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                Text("Forgot password ?")
                    .font(.footnote)
                    .padding(.bottom, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, -10)
                        
                Button(action: {
                }) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .frame(maxWidth: 120)
                        .padding()
                        .background(Color.black) // You can also change this to your pastel green color
                        .cornerRadius(8)
                }
                
                Button(action: {
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .frame(maxWidth: 120)
                        .padding()
                        .background(Color.black) // You can also change this to your pastel green color
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding(.horizontal, 40)
        }
        .onTapGesture {
//            self.endEditing(true)  // This will dismiss the keyboard when tapping outside
        }
    }
    
}



#Preview {
    LoginView(viewModel: LoginViewModel())
}
