//
//  VButton.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import SwiftUI



struct VButton: View {
    let action: () -> Void
    let title: String
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .foregroundColor(.viInvertedText)
                .frame(maxWidth: 120)
                .padding()
                .background(.viBackground)
                .cornerRadius(8)
        }
    }
}
