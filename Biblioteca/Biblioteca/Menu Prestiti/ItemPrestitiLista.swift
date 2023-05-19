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
    
    @StateObject var viewModel = ViewModel()
        
    init(prestitoLibro: Prestito) {
        self.prestitoLibro = prestitoLibro
        self.titoloLibro = String(prestitoLibro.idCopia)
        
        //self.prestitoLibro = libro.prestito
    }
    
    var body: some View {
        HStack{
            ZStack(alignment: .topTrailing){
                CachedAsyncImage(url: URL(string: viewModel.libro.image ?? "")){ image in
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
                viewModel.getCopieDaIdCopia(idCopia: String(prestitoLibro.idCopia))
            }
            
            VStack(alignment: .leading){
                Text(viewModel.libro.titolo)
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

@available(iOS 15.0, *)
extension ItemPrestitiLista {
    class ViewModel: ObservableObject {
        @Published var libro = DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil)
                        
        init() {
            getCopieDaIdCopia(idCopia: "")
        }
        
        func getCopieDaIdCopia(idCopia: String){
            GestioneJson().getCopieDallId(idCopia: idCopia){ libro, errore in
                DispatchQueue.main.async() {
                    if let libro = libro {                        
                        self.libro = libro
                        
                    }else {
                        //print(errore?.localizedDescription ?? "error")
                    }
                }
                
            }
        }
    }
}

struct ItemPrestitiLista_Previews: PreviewProvider {
    static var previews: some View {
        ItemPrestitiLista(prestitoLibro: Prestito(idPrestito: 0, idCopia: 0, idUtente: 0, dataFine: nil, dataInizio: nil, condizioneIniziale: nil, condizioneFinale: nil, attivo: false))
    }
}
