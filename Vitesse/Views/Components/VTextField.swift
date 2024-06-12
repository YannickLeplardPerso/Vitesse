//
//  VTextField.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import SwiftUI



struct VTextField: View {
    let title: String
    @Binding var text: String
    let isSecure: Bool
    let error: VError
    
    // pour pouvoir avoir une valeur par défaut pour isSecure et rendre le paramètre optionnel pour un "simple" TextField
    init(title: String, text: Binding<String>, isSecure: Bool = false, error: VError = .No) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
        self.error = error
    }
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(.viText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            Group {
                if isSecure {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            .padding()
            .background(.viBackgroundField)
            .cornerRadius(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(error != .No ? .red : Color(.viBackgroundField), lineWidth: 1)
            )
            .autocapitalization(.none)
            .disableAutocorrection(true)
        }
        
    }
}



//struct VTextField_Previews: PreviewProvider {
//    @State static var field: String = ""
//
//    static var previews: some View {
//        VTextField(title: "Email", text: $field)
////            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}

//#Preview {
//    @State static var field: String = ""
//    VTextField(title: "email", text:$field)
//}
