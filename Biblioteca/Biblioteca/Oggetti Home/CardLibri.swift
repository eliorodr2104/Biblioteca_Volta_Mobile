/**
 * Created by eliomar rodriguez on 22/03/23.
 *
 * Descrizione: La vista è definita come una struttura che contiene due proprietà, "titolo" e "descrizione", entrambe di tipo String. La vista ha un corpo "body" che restituisce
 *          un'istanza di ZStack contenente un RoundedRectangle, un VStack e alcune proprietà per impostare l'aspetto della card.
 *
 *          Il VStack contiene due Text elementi, uno per il titolo e uno per la descrizione del libro, e alcuni metodi di modifica per impostare la formattazione del testo. La ZStack
 *          viene utilizzata per sovrapporre il RoundedRectangle e il VStack, dando alla card un aspetto 3D.
 *
 * Progetto: Biblioteca
 * SwiftUI view CardLibri.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca


/**
 * Struttura CardLibri
 *
 * Descrizione: La vista è definita come una struttura che contiene due proprietà, "titolo" e "descrizione", entrambe di tipo String. La vista ha un corpo "body" che restituisce
 *          un'istanza di ZStack contenente un RoundedRectangle, un VStack e alcune proprietà per impostare l'aspetto della card.
 *
 *          Il RoundedRectangle viene definito con un arrotondamento del bordo di 20 e viene riempito con il colore bianco, cui viene applicata un'ombra di colore "ColoreCard".
 *          Questo dà alla card un aspetto 3D e un po' di profondità.
 *
 *          Il VStack contiene due Text elementi, uno per il titolo e uno per la descrizione del libro. Il testo del titolo viene impostato come grassetto, di dimensione "title" e con un
 *          margine inferiore di 0.
 *
 *          Il testo della descrizione viene impostato come "body", centrato e con un margine inferiore di 10. Entrambi i testi hanno il colore del testo
 *          impostato su nero.
 *
 *          Il frame del VStack viene impostato per riempire tutto lo spazio disponibile all'interno della ZStack, impostando l'allineamento su bottomLeading e aggiungendo un
 *          margine inferiore di 10.
 *
 *          Infine, la vista è avvolta in un frame per impostare le dimensioni della card.
 */
struct CardLibri: View {
    
    var libro: DatiLibro
    var titolo: String
    var descrizione: String?
    
    init(libro: DatiLibro) {
        self.libro = libro
        self.titolo = libro.titolo
        self.descrizione = libro.descrizione
    }
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: Color("ColoreCard"), radius: 6)
            
            VStack(alignment: .leading) {
                Text(titolo)
                    .foregroundColor(Color.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 0)
                
                Text(descrizione ?? "")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading) // Imposta l'allineamento del frame del VStack su bottomLeading
            .padding(.bottom, 10) // Aggiungi un margine inferiore al VStack
        }
        .frame(width: 155, height: 270)
    }
}



struct CardLibri_Previews: PreviewProvider {
    static var previews: some View {
        CardLibri(libro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategoria: 0, idGenere: 0, descrizione: nil, image: nil))
        
    }
}
