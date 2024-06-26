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
    @Binding var error: VError
    
    // to force a default value for isSecure and make this parameter optional
    init(title: String, text: Binding<String>, error: Binding<VError>, isSecure: Bool = false) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
        self._error = error
    }
    
    var body: some View {
        VStack {
            VLabelText(text: title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            Group {
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
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
            .onChange(of: text) {
                error = .No
            }
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
