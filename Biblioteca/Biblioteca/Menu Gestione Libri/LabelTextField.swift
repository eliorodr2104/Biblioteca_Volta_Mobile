//
//  LabelTextField.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 18/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct LabelTextField: View {
    
    private var labelName: String
    private var textFieldText: String
    private var textState: Binding<String>
    
    @State private var avviaAnimazione: Bool
        
    init(labelName: String, textFieldText: String, textState: Binding<String>) {
        self.labelName = labelName
        self.textFieldText = textFieldText
        self.textState = textState
        
        self.avviaAnimazione = textState.wrappedValue != ""
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if avviaAnimazione {
                Text(labelName)
                    .font(.headline)
                    //.bold()
                    .offset(y: 0)
                    .animation(.easeInOut(duration: 0.1), value: avviaAnimazione)
                    .transition(.move(edge: .top))
            }
                
            TextField(textFieldText, text: textState)
                .onChange(of: textState.wrappedValue) { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        avviaAnimazione = textState.wrappedValue != "" ? true : false
                    }
                }
        }
    }
}

struct LabelTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabelTextField(labelName: "", textFieldText: "", textState: .constant(""))
    }
}
