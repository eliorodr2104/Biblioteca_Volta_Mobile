//
//  ItemPrestitiLista.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 14/04/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import sharedModuleBiblioteca

struct ItemPrestitiLista: View {
    
    var prestitoLibro: Prestito
    
    private var titoloLibro: String
    //private var prestitoLibro: Prestito
    
    init(prestitoLibro: Prestito) {
        self.prestitoLibro = prestitoLibro
        self.titoloLibro = String(prestitoLibro.idCopia)
        //self.prestitoLibro = libro.prestito
    }
    
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            }
            .frame(width: 55, height: 75)
            .padding(.trailing, 10)
            .padding(.bottom, 23)
            
            VStack(alignment: .leading){
                Text(titoloLibro)
                    .font(.title3)
                    .padding(.top, 1)
                
                /*
                Text("Tempo restante: " + prestitoLibro.dataInizio!)
                    .font(.subheadline)
                    .padding(.bottom, 36)
                 */
                Text("Tempo restante: PROVA/PROVA/ITEMPRESTITILISTA")
                    .font(.subheadline)
                    .padding(.bottom, 36)
            }
        }
    }
}

struct ItemPrestitiLista_Previews: PreviewProvider {
    static var previews: some View {
        ItemPrestitiLista(prestitoLibro: Prestito(idPrestito: 0, idCopia: 0, idUtente: 0, dataFine: nil, dataInizio: nil, condizioneIniziale: nil, condizioneFinale: nil, attivo: false))
    }
}
