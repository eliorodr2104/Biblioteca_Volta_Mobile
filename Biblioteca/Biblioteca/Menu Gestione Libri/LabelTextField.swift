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
        
    init(labelName: String, textFieldText: String, textState: Binding<String>) {
        self.labelName = labelName
        self.textFieldText = textFieldText
        self.textState = textState
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if textState.wrappedValue != ""{
                Text(labelName)
                    .font(.headline)
                    .offset(y: 0)
                    .animation(.easeInOut(duration: 0.1))
                    .transition(.move(edge: .top))
            }
                
            TextField(textFieldText, text: textState)
            //.background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0), cornerRadius: 5.0)
        }
        //.padding(.horizontal, 15)
    }
}

struct LabelTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabelTextField(labelName: "", textFieldText: "", textState: .constant(""))
    }
}
