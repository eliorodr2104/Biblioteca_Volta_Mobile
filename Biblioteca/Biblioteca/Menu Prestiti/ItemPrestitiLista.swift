//
//  ItemPrestitiLista.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 14/04/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import sharedModuleBiblioteca
import CachedAsyncImage

struct ItemPrestitiLista: View {
    
    var prestitoLibro: Prestito
    
    private var titoloLibro: String
    //private var prestitoLibro: Prestito
    
    @StateObject var httpManager = HttpManager()
        
    init(prestitoLibro: Prestito) {
        self.prestitoLibro = prestitoLibro
        self.titoloLibro = String(prestitoLibro.idCopia)
        
        //self.prestitoLibro = libro.prestito
    }
    
    var body: some View {
        HStack{
            ZStack(alignment: .topTrailing){
                CachedAsyncImage(url: URL(string: httpManager.datiLibro.image ?? "")){ image in
                    image.resizable(resizingMode: .stretch)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 55, height: 75)
            }
            .frame(width: 55, height: 75)
            .padding(.trailing, 10)
            .padding(.bottom, 23)
            .onAppear(){
                httpManager.getCopieDaIdCopia(idCopia: String(prestitoLibro.idCopia))
            }
            
            VStack(alignment: .leading){
                Text(httpManager.datiLibro.titolo)
                    .font(.title3)
                
                /*
                Text("Tempo restante: " + prestitoLibro.dataInizio!)
                    .font(.subheadline)
                    .padding(.bottom, 36)
                 */
                Text("Data fine: " + (prestitoLibro.dataFine ?? ""))
                    .font(.subheadline)
                    .padding(.bottom, 50)
            }
        }
    }
}

struct ItemPrestitiLista_Previews: PreviewProvider {
    static var previews: some View {
        ItemPrestitiLista(prestitoLibro: Prestito(idPrestito: 0, idCopia: 0, idUtente: 0, dataFine: nil, dataInizio: nil, condizioneIniziale: nil, condizioneFinale: nil, attivo: false))
    }
}
