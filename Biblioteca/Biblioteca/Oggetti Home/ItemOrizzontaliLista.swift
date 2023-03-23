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
    
    var body: some View {
        
        HStack {
            cardPrimi
                .padding(10)
                
            Spacer()
                
            cardSecondo
                .padding(10)
        }
        .padding(15)
    }
}

struct ItemOrizzontaliLista_Previews: PreviewProvider {
    static var previews: some View {
        ItemOrizzontaliLista()
    }
}
