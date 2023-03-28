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
                .shadow(color: Color("ColoreCard"), radius: 6)
            
            VStack(alignment: .leading) {
                Text(titolo)
                    .foregroundColor(Color.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 0)
                
                Text(descrizione)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading) // Imposta l'allineamento del frame del VStack su bottomLeading
            .padding(.bottom, 10) // Aggiungi un margine inferiore al VStack
        }
        .frame(width: 155, height: 270)
    }
}


struct CardLibri_Previews: PreviewProvider {
    static var previews: some View {
        CardLibri()
    }
}
