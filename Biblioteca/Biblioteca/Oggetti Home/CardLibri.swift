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
@available(iOS 15.0, *)
struct CardLibri: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var libro: DatiLibro
    var titolo: String
    
    @State private var imageSize: CGSize = .zero
    
    init(libro: DatiLibro) {
        self.libro = libro
        self.titolo = libro.titolo
        self.viewModel = ViewModel(isbn: libro.isbn)
    }
    
    var body: some View {
        let copieLibro = getRisultatoCopie(copieLibro: viewModel.libro?.copie as? [CopiaLibro]) > 0
        
        ZStack(alignment: .topTrailing){
            AsyncImage(url: URL(string: libro.image ?? "")){ image in
                image.resizable(resizingMode: .stretch)
            } placeholder: {
                Color.black
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: 155, height: 270)
            
            RoundedRectangle(cornerRadius: 100)
                .fill(copieLibro ? Color.green : Color.red)
                .frame(width: 30, height: 30)
                .padding(.top, -9)
                .padding(.trailing, -10)
            
        }
        .frame(width: 155, height: 270)
            
    }
}

@available(iOS 15.0, *)
extension CardLibri {
    class ViewModel: ObservableObject {
        @Published var libro: Libro?
        
        init(isbn: String) {
            GestioneJson().getCopieLibro(isbn: isbn) { libro, error in
                DispatchQueue.main.async {
                    if let libro = libro {
                        self.libro = libro
                    } else {
                        //print(error?.localizedDescription ?? "error")
                    }
                }
            }
        }
    }
}




@available(iOS 15.0, *)
struct CardLibri_Previews: PreviewProvider {
    static var previews: some View {
        CardLibri(libro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategoria: NSMutableArray(), idGenere: 0, descrizione: nil, np: 0, image: nil))
        
    }
}
