//
//  VText.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 25/06/2024.
//

import SwiftUI



struct VText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundStyle(.cyan)
            .fontWeight(.semibold)
    }
}
