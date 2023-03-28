//
//  ItemOrizzontaliLista.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 22/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct ItemOrizzontaliLista: View{
    var cardPrimi = CardLibri(titolo: "", descrizione: "")
    var cardSecondo = CardLibri(titolo: "", descrizione: "")
    
    var funzionePrimaCard: () -> Void
    var funzioneSecondaCard: () -> Void

        
    var body: some View {
        HStack {
            Button(action: funzionePrimaCard){
                cardPrimi
            }
            .padding(10)
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
                
            Button(action: funzioneSecondaCard){
                cardSecondo
            }
            .padding(5)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(10)
    }
    
    
}
struct ItemOrizzontaliLista_Previews: PreviewProvider {
    static var previews: some View {
        ItemOrizzontaliLista(funzionePrimaCard: {}, funzioneSecondaCard: {})
    }
}
