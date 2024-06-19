//
//  VitesseApp.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 08/06/2024.
//

import SwiftUI

@main
    struct VitesseApp: App {
    @StateObject var vstate = VState()
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
        .environmentObject(vstate)
    }
}
