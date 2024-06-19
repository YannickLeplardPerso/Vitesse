//
//  VTitleText.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import SwiftUI



struct VTitleText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.viText)
            .padding(20)
    }
}



//#Preview {
//    VTitleText(text: "Titre : ex. Login")
//}
