//
//  VSubText.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 25/06/2024.
//

import SwiftUI



struct VSubText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.cyan)
            .fontWeight(.semibold)
    }
}
