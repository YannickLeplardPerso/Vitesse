//
//  RegisterView.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 04/06/2024.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                Text("First Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                TextField("First Name", text: $viewModel.firstName)
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
                
                Text("Last Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                TextField("Last Name", text: $viewModel.lastName)
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
                SecureField("Password", text: $viewModel.newPassword)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .padding(.bottom, 20)
                
                Text("Confirm Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                SecureField("Confirm Password", text: $viewModel.confirmNewPassword)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    
                Spacer()
                
                Button(action: {
                }) {
                    Text("Create")
                        .foregroundColor(.white)
                        .frame(maxWidth: 120)
                        .padding()
                        .background(Color.black)
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
    RegisterView(viewModel: RegisterViewModel())
}
