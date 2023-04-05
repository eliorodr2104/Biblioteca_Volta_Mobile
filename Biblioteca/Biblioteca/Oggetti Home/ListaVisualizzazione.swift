/**
 * Created by eliomar rodriguez on 22/03/23.
 *
 * Descrizione: Questo codice definisce una vista ListaVisualizzazione che visualizza una lista di elementi orizzontali. La lista viene visualizzata in due modi diversi a seconda della
 * larghezza della vista: se è maggiore di 700 punti, viene utilizzato uno ScrollView con una LazyVGrid per visualizzare la lista in modo responsivo, mentre se la larghezza è inferiore
 * a 700 punti, viene utilizzata una NavigationView con una lista standard. La lista viene creata a partire da un array di oggetti ItemOrizzontaliLista, che rappresentano due card di
 * libri orizzontali con rispettive funzioni di azione associate.
 *
 * La vista inizia con la definizione di una costante greet, che viene inizializzata con il saluto restituito dal metodo greet() dell'oggetto Greeting dal modulo sharedModuleBiblioteca.
 * Poi, la vista viene definita come una GeometryReader, che misura la dimensione disponibile della vista e seleziona la modalità di visualizzazione della lista.
 *
 * Nel caso in cui la larghezza sia maggiore di 700 punti, viene definito un array di GridItem che specifica due colonne flessibili per la vista responsiva, poi la lista viene visualizzata
 * all'interno di uno ScrollView e una LazyVStack. Altrimenti, se la larghezza è inferiore a 700 punti, viene utilizzata una NavigationView con una lista standard.
 *
 * All'interno della vista, viene utilizzata la costruzione ForEach per iterare attraverso gli elementi dell'array listaItemOrizzontale e visualizzare un elemento orizzontale della lista.
 * La costruzione ForEach genera una ItemOrizzontaliLista per ogni elemento dell'array, passando le rispettive cardPrimi, cardSecondo, funzionePrimaCard e funzioneSecondaCard.
 *
 * In entrambi i casi, la vista mostra il titolo "Lista dei libri" in una font di grandi dimensioni e in grassetto, e il colore di sfondo è impostato su UIColor.systemBackground. La lista è
 * impaginata con margini e spaziatura per migliorare l'aspetto complessivo della vista.
 *
 * Progetto: Biblioteca
 * SwiftUI view ListaVisualizzazione.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

struct ListaVisualizzazione: View {
    /*
     * Variabile statica la quale prende il valore della funzione "greet()" (VARIABILE_DI_PROVA) la quale è fatta in codice
     * kotlin
     */
    let greet = Greeting().greet()
    
    //Array di oggetti "ItemOrizzontaliLista" di tipo "view"
    var listaItemOrizzontale = [ItemOrizzontaliLista]()
    
    var body: some View {
        //Lettura delle dimensioni dello schermo nel quale si avvia la app
        GeometryReader { geometry in
            
            /*
             * Struttura condizionale la quale verifica se la dimensione dello schermo è maggiora di 700, s'è vero si crea
             * una variabile statica con il "GridItem" per le colonne e si crea la visualizzazione adatta per il tablet,
             * altrimenti imposta la visuale per la versione mobile
             */
            if geometry.size.width > 700 {
                //Array statico, il quale ha al suo interno delle griglie per fare delle colonne 16x16
                let columns = [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ]
                
                /*
                 * La vista ScrollView è utilizzata per permettere lo scorrimento dell'intera lista quando la sua altezza supera
                 * quella dello schermo. La vista LazyVStack contiene il titolo della lista, "Lista dei libri",
                 e la griglia di elementi.
                 *
                 * La griglia è implementata con LazyVGrid e definisce il numero di colonne e lo spazio tra le colonne attraverso
                 * la dichiarazione di un array di GridItem. La griglia contiene un ForEach che cicla su tutti gli elementi della
                 * lista e per ciascun elemento utilizza la vista ItemOrizzontaliLista per renderlo graficamente.
                 */
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
                /*
                 * Vista NavigationView, che consente di creare un'interfaccia a schermo intero che contiene una barra di
                 * navigazione sulla parte superiore dello schermo.
                 *
                 * All'interno della NavigationView, viene creato un List di elementi, dove ogni elemento è rappresentato da una
                 * ItemOrizzontaliLista, creata utilizzando i dati contenuti nell'array listaItemOrizzontale.
                 *
                 * La proprietà listStyle(.plain) indica che il layout della lista deve essere semplice, senza l'utilizzo di
                 * un'immagine o di altri elementi grafici per rappresentare gli elementi della lista.
                 *
                 * Infine, la proprietà navigationTitle viene utilizzata per impostare il titolo della barra di navigazione sulla
                 * parte superiore dello schermo. Nel caso specifico, il titolo è impostato su "Lista dei libri".
                 */
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
