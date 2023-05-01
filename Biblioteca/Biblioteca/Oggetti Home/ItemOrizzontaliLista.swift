/**
 * Created by eliomar rodriguez on 22/03/23.
 *
 * Descrizione: Questo codice definisce una vista SwiftUI chiamata ItemOrizzontaliLista, che contiene due carte di libri (cardPrimi e cardSecondo) posizionate orizzontalmente una
 *          accanto all'altra all'interno di un HStack. Queste due carte vengono rese cliccabili grazie alla presenza di due bottoni (Button),
 *          ognuno dei quali viene associato ad una funzione specifica (rispettivamente funzionePrimaCard e funzioneSecondaCard) che viene eseguita al momento del click.
 *
 *          All'interno del corpo della vista, la prima carta (cardPrimi) viene posizionata all'inizio dell'HStack, seguita da uno spazio (Spacer()) e dalla seconda carta
 *          (cardSecondo) posizionata alla fine. Entrambi i bottoni utilizzano uno stile di pulsante plain (PlainButtonStyle()) per rimuovere la decorazione predefinita.
 *
 * Progetto: Biblioteca
 * SwiftUI view ItemOrizzontaliLista.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

struct ItemOrizzontaliLista: View{
    //Dichiarazione e inizializzazione delle due "Card" dove
    var cardPrimi = CardLibri(libro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategoria: 0, idGenere: 0, descrizione: nil, image: nil))
    
    var cardSecondo = CardLibri(libro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategoria: 0, idGenere: 0, descrizione: nil, image: nil))
    
    /*
     * Dichiarazione e inizializzazione delle due funzioni che avvengono quando si preme il rispettivo pulsante alla quale
     * appartiene la "Card"
     */
    var funzionePrimaCard: () -> Void
    var funzioneSecondaCard: () -> Void

        
    var body: some View {
        //Visualizzazione orizzontale nella quale ci sono le due "Card" che si vedono nella schermata principale
        HStack {
            //Pulsante che prende la forma della prima "Card"
            Button(action: funzionePrimaCard){
                cardPrimi
            }
            .padding(10)
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
                
            //Pulsante che prende la forma della seconda "Card"
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
