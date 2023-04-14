/**
 * Created by eliomar rodriguez on 23/03/23.
 *
 * Descrizione: Struttura MenuLibro che rappresenta un singolo elemento di una lista di libri. La struttura accetta quattro parametri: titolo, autore, numeroCopie e disponibilitaLibro.
 *
 * Inoltre, la struttura ha una variabile di stato chiamata controlloDimensione che è inizializzata con il valore booleano false.
 *
 * Il corpo della struttura contiene un GeometryReader che viene utilizzato per determinare la larghezza dell'area in cui viene visualizzato il MenuLibro. In base a ciò,
 * viene impostata una variabile booleana isLargeSize che viene utilizzata successivamente per determinare la dimensione dei font e dei margini.
 *
 * All'interno del GeometryReader, c'è uno ZStack che contiene un VStack per visualizzare il contenuto del libro, tra cui l'immagine, il titolo, l'autore e lo stato di disponibilità.
 *
 * Il VStack è diviso in due parti da un HStack. La prima parte contiene l'immagine del libro e la seconda parte contiene il titolo, l'autore e lo stato di disponibilità.
 * L'immagine del libro è racchiusa in un ZStack con un arrotondamento dei bordi, un riempimento bianco e un'ombra. La larghezza e l'altezza sono impostate a 113 e 175
 * rispettivamente, con un margine orizzontale di 10.
 *
 * La seconda parte del VStack contiene il titolo del libro, l'autore e lo stato di disponibilità. La dimensione dei font è impostata in base alla variabile booleana isLargeSize. Se
 * disponibilitaLibro è true, viene visualizzato lo stato di disponibilità del libro e il numero di copie disponibili.
 *
 * Infine, il MenuLibro ha un margine superiore di 20.
 *
 * Progetto: Biblioteca
 * SwiftUI view MenuLibro.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

struct MenuLibro: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var titolo: String?
    var autore: String?
    var numeroCopie: Int?
    var disponibilitaLibro: Bool?
    
    //Variabile di stato booleana
    @State var controlloDimensione = false
        
    var body: some View {
        
        //Lettura delle dimensioni dello schermo nel quale si avvia la app
        GeometryReader { geometry in
            
            //Variabile statica booleana, la quale controlla se la dimensione dello schermo è maggiore o uguale a 700
            let isLargeSize = geometry.size.width >= 700
            
            //Corpo della schermata
            ZStack {
                
                //Visualizazzione verticale la quale mostra i elementi allineati a sinistra dello schermo
                VStack(alignment: .leading){
                    
                    //Visualizzazione orizzontale dove ci sono le informazioni principale del libro anche con l'immagine
                    HStack(alignment: .top){
                        
                        //Corpo del rettangolo che ha la copertina del libro
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(color: Color("ColoreCard"), radius: 6)
                            
                            Image("")
                            
                        }
                        .frame(width: 113, height: 175)
                        .padding(.horizontal, 10)
                        
                        Spacer(minLength: 5)
                        
                        /*
                         * Visualizzazione verticale la quale si mettono tutti i "Text" con le informazioni principali del libro,
                         * fa anche un ulteriore controllo per la dimensione del testo con la variabile statica "isLargeSize"
                         */
                        VStack(alignment: .leading) {
                            
                            Text(viewModel.text)
                                .fontWeight(.bold)
                                .font(isLargeSize ? .largeTitle : .title)
                                .foregroundColor(.primary)
                            
                            Text(autore ?? "")
                                .fontWeight(.bold)
                                .font(isLargeSize ? .headline : .subheadline)
                                .foregroundColor(.primary.opacity(0.5))
                            
                            /*
                             * Struttura condizionale la quale controlla che la variabile "disponibilitaLibro" sia True; s'è
                             * vero setta la disponibilità in "disponibile" e da anche il numero di copie rimasto, altrimenti,
                             * setta il libro come non disponibile
                             */
                            if disponibilitaLibro ?? false {
                                Text("Disponibile")
                                    .fontWeight(.bold)
                                    .font(isLargeSize ? .body : .subheadline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 5)
                                
                                Text("Il numero di copie di copie è: " + String(numeroCopie ?? 0))
                                    .fontWeight(.bold)
                                    .font(isLargeSize ? .headline : .subheadline)
                                    .foregroundColor(.primary.opacity(0.5))
                                    .padding(.bottom, 5)
                            } else {
                                Text("Non disponibile al prestito")
                                    .fontWeight(.bold)
                                    .font(isLargeSize ? .body : .subheadline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.horizontal, isLargeSize ? 20 : 10)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

extension MenuLibro {
    class ViewModel: ObservableObject {
        @Published var text = "Loading..."
        init() {
            GestioneJson().provaConnessione { connessione, error in
                DispatchQueue.main.async {
                    if let connessione = connessione {
                        self.text = connessione
                    } else {
                        self.text = error?.localizedDescription ?? "error"
                    }
                }
            }
        }
    }
}

struct MenuLibro_Previews: PreviewProvider {
    static var previews: some View {
        MenuLibro(viewModel: MenuLibro.ViewModel(), titolo: "", autore: "", numeroCopie: 0 ,disponibilitaLibro: true)
    }
}
