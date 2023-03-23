//
//  ListaVisualizzazione.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 22/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct ListaVisualizzazione: View {
    var body: some View {
        NavigationView{
            List{
                ItemOrizzontaliLista(cardPrimi: CardLibri(titolo: "Titolo1", descrizione: "greet"), cardSecondo: CardLibri(titolo: "Titolo2", descrizione: "greet"))
                
                ItemOrizzontaliLista(cardPrimi: CardLibri(titolo: "Titolo2", descrizione: "greet"), cardSecondo: CardLibri(titolo: "Titolo3", descrizione: "greet"))
                
                ItemOrizzontaliLista(cardPrimi: CardLibri(titolo: "Titolo3", descrizione: "greet"), cardSecondo: CardLibri(titolo: "Titolo4", descrizione: "greet"))
                
            }
            .background(Color(UIColor.systemBackground))
            .navigationTitle("Lista dei libri")
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct ListaVisualizzazione_Previews: PreviewProvider {
    static var previews: some View {
        ListaVisualizzazione()
    }
}
