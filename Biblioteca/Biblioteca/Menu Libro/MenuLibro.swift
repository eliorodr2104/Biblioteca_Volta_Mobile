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

@available(iOS 15.0, *)
struct MenuLibro: View {
    
    var datiLibro: DatiLibro
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    init(datiLibro: DatiLibro) {
        self.datiLibro = datiLibro
        self.viewModel = ViewModel(isbn: datiLibro.isbn, listaCategorie: datiLibro.idCategoria)
    }
    
    //Variabile di stato booleana
    @State var controlloDimensione = false
        
    var body: some View {
        let items: [Etichetta] = inizializzaCategorie(arrayCategorie: viewModel.arrayCategorie as! [String])
        
        let nCopieDisponibili = getRisultatoCopie(copieLibro: viewModel.libro?.copie as? [CopiaLibro])
        
        //Lettura delle dimensioni dello schermo nel quale si avvia la app
        GeometryReader { geometry in
            
            //Variabile statica booleana, la quale controlla se la dimensione dello schermo è maggiore o uguale a 700
            let isLargeSize = geometry.size.width >= 700
            
            //Corpo della schermata
            ZStack {
                
                //Visualizazzione verticale la quale mostra i elementi allineati a sinistra dello schermo
                VStack(alignment: .leading){
                    
                    //Visualizzazione orizzontale dove ci sono le informazioni principale del libro anche con l'immagine
                    HStack(alignment: .center){
                        
                        //Corpo del rettangolo che ha la copertina del libro
                        ZStack{
                            AsyncImage(url: URL(string: datiLibro.image ?? "")){ image in
                                image.resizable(resizingMode: .stretch)
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(width: 113, height: 175)
                            .overlay {
                                if nCopieDisponibili > 0{
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color("ColorePrincipale"))
                                        .frame(width: 14, height: 13)
                                        .padding(.bottom, 145)
                                        .padding(.trailing, 85)
                                        
                                    Text(String(nCopieDisponibili))
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 145)
                                        .padding(.trailing, 85)
                                }
                            }
                            
                        }
                        .frame(width: 113, height: 175)
                        .padding(.horizontal, 10)
                                                
                        /*
                         * Visualizzazione verticale la quale si mettono tutti i "Text" con le informazioni principali del libro,
                         * fa anche un ulteriore controllo per la dimensione del testo con la variabile statica "isLargeSize"
                         */
                        VStack(alignment: .leading) {
                            
                            Text(datiLibro.titolo )
                                .fontWeight(.bold)
                                .font(isLargeSize ? .largeTitle : .title)
                                .foregroundColor(.primary)
                                .padding(.top, 55)
                            
                            //DA MODIFICARE CON L'AUTORE DEL LIBRO ANZI CHE L'ID
                            Text(String(datiLibro.autore ) == "" ? "Autore sconosciuto" : String(datiLibro.autore ))
                                .fontWeight(.bold)
                                .font(isLargeSize ? .headline : .subheadline)
                                .foregroundColor(.primary.opacity(0.5))
                            
                            Text("La lingua del libro è: " + GestioneRisorseKt.conversioneLinguaLibro(linguaDelLibro: datiLibro.lingua ))
                                .fontWeight(.bold)
                                .font(isLargeSize ? .headline : .subheadline)
                                .foregroundColor(.primary.opacity(0.75))
                                .padding(.top, 20)
                            
                            
                            Text(nCopieDisponibili > 0 ? "Il libro è disponibile" : "Il libro non è disponibile")
                                .fontWeight(.bold)
                                .font(isLargeSize ? .body : .subheadline)
                                .foregroundColor(.primary.opacity(0.75))
                            
                        }
                        //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        
                    }
                    
                    Divider()
                        .background(Color.white)
                        .padding(.vertical, 11)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(items.indices, id: \.self) { index in
                                items[index]
                            }
                        }
                        .frame(height: 30)
                    }
                    .frame(height: 30)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                    
                    if (datiLibro.descrizione?.count ?? 0 <= 764){
                        HStack(alignment: .top){
                            Text(datiLibro.descrizione ?? "")
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.top, 10)
                        
                    }else{
                        ScrollView {
                            //Text(datiLibro?.descrizione ?? "")
                            Text(datiLibro.descrizione ?? "")
                                .padding(.trailing, 10)
                                .multilineTextAlignment(.leading)
                                .frame(width: geometry.size.width)
                                
                        }
                        .padding(.top, 10)
                        .padding(.leading, 10)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

func getRisultatoCopie(copieLibro: [CopiaLibro]?) -> Int{
    var contaLibri = 0
            
    if copieLibro != nil{
        for i in stride(from: 0, to: copieLibro?.count ?? 0, by: 1){
            
            if copieLibro?[i].inPrestito != true{
                contaLibri += 1
            }
        }
                
        return contaLibri
        
    }else{
        return 0
    }
    
    
}

private func inizializzaCategorie(arrayCategorie: [String]) -> [Etichetta]{
    var arrayEtichette = [Etichetta]()
    
    for i in stride(from: 0, to: arrayCategorie.count, by: 1){
        arrayEtichette.append(Etichetta(nomeEtichetta: arrayCategorie[i]))
    }
    
    return arrayEtichette
}


@available(iOS 15.0, *)
extension MenuLibro {
    class ViewModel: ObservableObject {
        @Published var libro: Libro?
        @Published var arrayCategorie = NSMutableArray()
        
        init(isbn: String, listaCategorie: NSMutableArray) {
            GestioneJson().getCopieLibro(isbn: isbn) { libro, error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let libro = libro {
                        self.libro = libro
                        
                    } else {
                        //print(error?.localizedDescription ?? "error")
                    }
                }
            }
            
            GestioneJson().getCategorie(listaIdCategoria: listaCategorie) { arrayCategorie, error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let arrayCategorie = arrayCategorie {
                        self.arrayCategorie = arrayCategorie
                        
                    } else {
                        //print(error?.localizedDescription ?? "error")
                    }
                }
            }
        }
    }
}


@available(iOS 15.0, *)
struct MenuLibro_Previews: PreviewProvider {
    static var previews: some View {
        MenuLibro(datiLibro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategoria: NSMutableArray(), idGenere: 0, descrizione: nil, np: 0, image: nil))
    }
}
