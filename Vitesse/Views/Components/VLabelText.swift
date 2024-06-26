//
//  VsubitText.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 25/06/2024.
//

import SwiftUI



struct VLabelText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.viText)
            //.frame(maxWidth: .infinity, alignment: .leading)
            //.padding(.top, 10)
    }
}
