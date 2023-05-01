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
    
    var libro: CopiaLibro
    
    private var titoloLibro: String
    //private var prestitoLibro: Prestito
    
    init(libro: CopiaLibro) {
        self.libro = libro
        self.titoloLibro = String(libro.isbn)
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
        ItemPrestitiLista(libro: CopiaLibro(idCopia: "", isbn: "", condizioni: "", inPrestito: false, sezione: "", scaffale: 0, ripiano: 0, np: 0, idPrestito: 0))
    }
}
