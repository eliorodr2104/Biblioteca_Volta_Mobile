/**
 * Created by eliomar rodriguez on 27/03/23.
 *
 * Descrizione: viene utilizzata la GeometryReader per controllare la larghezza dello schermo del dispositivo in cui viene eseguita l'app.
 * Se la larghezza è inferiore a 700 punti, viene visualizzata la vista MenuSplit, altrimenti viene visualizzata la vista MenuSplitTablet.
 * Questo consente di creare una versione dell'app con una diversa interfaccia utente a seconda delle dimensioni dello schermo.
 *
 * La vista MenuSplit o MenuSplitTablet potrebbero essere altre viste personalizzate dell'applicazione, che mostrano il menu principale
 * dell'applicazione.
 *
 * Progetto: Biblioteca
 * SwiftUI view Login.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

@available(iOS 15.0, *)
struct ContentView: View {
	var body: some View {
        //Login()
        
        /*
         * Il codice utilizza il costrutto GeometryReader per ottenere informazioni sulle dimensioni della
         * vista in cui viene mostrato. In base alla larghezza ottenuta, viene scelto il tipo di menu da
         * mostrare tra MenuSplit per dimensioni inferiori a 700 e MenuSplitTablet per dimensioni
         * superiori o uguali a 700.
         */
        GeometryReader { geometry in
            
            /*
             * Struttura condizionale che controlla se lo schermo ha lunghezza minore a 700,
             * s'è vero apre il menù per telefono, altrimenti apre la visuale per il tablet.
             */
            if geometry.size.width < 700 {
                MenuSplit(nomeUtente: "Eliomar", salutoUtente: "Ciao", utenteUtilizzo: Utente(idUtente: 1, nome: "Eliomar", cognome: "Rodriguez", numero: nil, mailAlternativa: "", grado: 3, mail: "eliomaralejandro.rodriguezferrer@volta-alessandria.it", preferiti: nil ), datiLibro: MenuLibro(datiLibro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil), index: .constant(0), showAnimationSecondary: .constant(false), show: .constant(false)))
                
            }else{
                MenuSplitTablet(viewModel: MenuSplitTablet.ViewModel(), nomeUtente: "Eliomar", salutoUtente: "Ciao")
            }
        }
         
	}
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
