//
//  ListaVisualizzazione.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 22/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import sharedModuleBiblioteca

struct ListaVisualizzazione: View {
    let greet = Greeting().greet()
    
    var listaItemOrizzontale = [ItemOrizzontaliLista]()
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > 700 {
                let columns = [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ]
                ScrollView {
                    LazyVStack(alignment: .leading){
                        Text("Lista dei libri")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(listaItemOrizzontale.indices, id: \.self) { index in
                                ItemOrizzontaliLista(cardPrimi: listaItemOrizzontale[index].cardPrimi, cardSecondo: listaItemOrizzontale[index].cardSecondo, funzionePrimaCard: listaItemOrizzontale[index].funzionePrimaCard, funzioneSecondaCard: listaItemOrizzontale[index].funzioneSecondaCard)
                            }
                        }
                        .padding()
                    }
                }
                .background(Color(UIColor.systemBackground))
                .edgesIgnoringSafeArea(.all)
            } else {
                NavigationView{
                    List {
                        ForEach(listaItemOrizzontale.indices, id: \.self) { index in
                            ItemOrizzontaliLista(cardPrimi: listaItemOrizzontale[index].cardPrimi, cardSecondo: listaItemOrizzontale[index].cardSecondo, funzionePrimaCard: listaItemOrizzontale[index].funzionePrimaCard, funzioneSecondaCard: listaItemOrizzontale[index].funzioneSecondaCard)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Lista dei libri")
                }
            }
        }
    }

}

struct ListaVisualizzazione_Previews: PreviewProvider {
    static var previews: some View {
        ListaVisualizzazione()
    }
}
