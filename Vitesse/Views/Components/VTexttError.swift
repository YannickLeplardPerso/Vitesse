//
//  VTexttError.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 11/06/2024.
//

import SwiftUI



struct VTextError: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.red)
    }
}

