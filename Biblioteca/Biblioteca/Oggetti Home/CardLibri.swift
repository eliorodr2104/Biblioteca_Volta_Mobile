//
//  CardLibri.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 22/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct CardLibri: View {
    var titolo: String = ""
    var descrizione: String = ""
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: 5)
            VStack{
                Text(titolo)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text(descrizione)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
            }
        }
        .frame(width: 155, height: 270)
    }
}

struct CardLibri_Previews: PreviewProvider {
    static var previews: some View {
        CardLibri()
    }
}
