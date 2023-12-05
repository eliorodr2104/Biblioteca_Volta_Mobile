/**
 * Created by eliomar rodriguez on 22/03/23.
 *
 * Descrizione:
 *
 * Progetto: Biblioteca
 * SwiftUI view ListaVisualizzazione.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

struct ListaVisualizzazione: View {
    //Chiamata al server per la richiesta dei libri (10 alla volta)
    @StateObject var httpManager = HttpManager()
    
    //Variabili di stato delle classi MenuSplit
    private var index: Binding<Int>
    private var datiLibro: Binding<MenuLibro>
    private var showAnimationSecondary: Binding<Bool>
    private var show: Binding<Bool>
    
    @State private var textSearch: String
        
    //Metodo costruttore
    init(index: Binding<Int>, datiLibro: Binding<MenuLibro>, showAnimationSecondary: Binding<Bool>, show: Binding<Bool>, textSearch: String = "") {
        self.index = index
        self.datiLibro = datiLibro
        self.showAnimationSecondary = showAnimationSecondary
        self.show = show
        
        self.textSearch = textSearch
    }
    
    //@State private var hashMapRicerca = Dictionary<String, Binding<String>>(dictionaryLiteral: ("", self.$textSearch))
    
    var body: some View {
        //Oggetti ItemVisualizzazione che viene inizializzato dalla funzione inializzaItem
        let tempArrayItemVisualizzazione = textSearch == "" ? inizializzaItem(index: index, CONST_INDEX_LIBRI: 10, datiLibro: datiLibro, showAnimationSecondary: showAnimationSecondary, libriVisualizzazioneRichiestaJson: httpManager.arrayLibri as! [DatiLibro], show: .constant(false), searchData: $textSearch) : inizializzaItem(index: index, CONST_INDEX_LIBRI: 10, datiLibro: datiLibro, showAnimationSecondary: showAnimationSecondary, libriVisualizzazioneRichiestaJson: httpManager.arrayLibriRicerca as! [DatiLibro], show: .constant(false), searchData: $textSearch)
        
        
        //Text("WEUUU: " + String(tempArrayItemVisualizzazione.count))
        
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
                            ForEach(tempArrayItemVisualizzazione.indices, id: \.self) { index in
                                
                                ItemOrizzontaliLista(cardPrimi: tempArrayItemVisualizzazione[index].cardPrimi, cardSecondo: tempArrayItemVisualizzazione[index].cardSecondo, funzionePrimaCard: tempArrayItemVisualizzazione[index].funzionePrimaCard, funzioneSecondaCard: tempArrayItemVisualizzazione[index].funzioneSecondaCard, show: show, ultimoItem: false, getData: httpManager, searchText: $textSearch)
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
                        ForEach(tempArrayItemVisualizzazione.indices, id: \.self) { index in
                            //Se è l'ultimo item lo mette a "true", altrimente a "false"
                            if textSearch == ""{
                                if index == (httpManager.arrayLibri.count - 1) / 2{
                                    ItemOrizzontaliLista(cardPrimi: tempArrayItemVisualizzazione[index].cardPrimi, cardSecondo: tempArrayItemVisualizzazione[index].cardSecondo, funzionePrimaCard: tempArrayItemVisualizzazione[index].funzionePrimaCard, funzioneSecondaCard: tempArrayItemVisualizzazione[index].funzioneSecondaCard, show: show, ultimoItem: true, getData: httpManager, searchText: $textSearch)
                                                                    
                                }else{
                                    ItemOrizzontaliLista(cardPrimi: tempArrayItemVisualizzazione[index].cardPrimi, cardSecondo: tempArrayItemVisualizzazione[index].cardSecondo, funzionePrimaCard: tempArrayItemVisualizzazione[index].funzionePrimaCard, funzioneSecondaCard: tempArrayItemVisualizzazione[index].funzioneSecondaCard, show: show, ultimoItem: false, getData: httpManager, searchText: $textSearch)
                                    
                                }
                                
                            }else{
                                if index == (httpManager.arrayLibriRicerca.count - 1) / 2{
                                    ItemOrizzontaliLista(cardPrimi: tempArrayItemVisualizzazione[index].cardPrimi, cardSecondo: tempArrayItemVisualizzazione[index].cardSecondo, funzionePrimaCard: tempArrayItemVisualizzazione[index].funzionePrimaCard, funzioneSecondaCard: tempArrayItemVisualizzazione[index].funzioneSecondaCard, show: show, ultimoItem: true, getData: httpManager, searchText: $textSearch)
                                                                    
                                }else{
                                    ItemOrizzontaliLista(cardPrimi: tempArrayItemVisualizzazione[index].cardPrimi, cardSecondo: tempArrayItemVisualizzazione[index].cardSecondo, funzionePrimaCard: tempArrayItemVisualizzazione[index].funzionePrimaCard, funzioneSecondaCard: tempArrayItemVisualizzazione[index].funzioneSecondaCard, show: show, ultimoItem: false, getData: httpManager, searchText: $textSearch)
                                    
                                }
                            }
                            
                            
                        }
                    }
                    .searchable(text: $textSearch)
                    .listStyle(.plain)
                    .allowsHitTesting(show.wrappedValue ? false : true)
                    .navigationTitle("Lista dei libri")
                    

                    .onChange(of: textSearch) { newValue in
                        httpManager.searchData(searchText: newValue)
                    }
                }
                .refreshable {
                    withAnimation {
                        if httpManager.nPagCatalogo != 0 {
                            httpManager.resetDataCatalogo()
                            httpManager.refreshLibriCatalogo()
                        }
                    }
                    
                }
                .onAppear{
                    httpManager.updateDataLibriCatalogo()
                }
            }
        }
    }
}

struct ItemOrizzontaliLista: View{
    //Dichiarazione e inizializzazione delle due "Card" dove
    var cardPrimi = CardLibri(libro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil))
    
    var cardSecondo = CardLibri(libro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil))
    
    /*
     * Dichiarazione e iniializzazione delle due funzioni che avvengono quando si preme il rispettivo pulsante alla quale
     * appartiene la "Card"
     */
    var funzionePrimaCard: () -> Void
    var funzioneSecondaCard: () -> Void
    
    var show: Binding<Bool>

    //Flag per specificare l'ultimo item
    var ultimoItem: Bool
    
    //Varaibile con il collegamento con il server
    @StateObject var getData: HttpManager
    
    @State var searchText: Binding<String>
        
    var body: some View {
        //Visualizzazione orizzontale nella quale ci sono le due "Card" che si vedono nella schermata principale
        if ultimoItem{
            HStack {
                //Pulsante che prende la forma della prima "Card"
                Button(action: funzionePrimaCard){
                    cardPrimi
                }
                .padding(10)
                .buttonStyle(PlainButtonStyle())
                .allowsHitTesting(show.wrappedValue ? false : true)
                
                Spacer()
                
                if cardSecondo.libro.isbn != ""{
                    //Pulsante che prende la forma della seconda "Card"
                    Button(action: funzioneSecondaCard){
                        cardSecondo
                    }
                    .padding(5)
                    .buttonStyle(PlainButtonStyle())
                    .allowsHitTesting(show.wrappedValue ? false : true)
                }
            }
            .onAppear(){
                getData.updateDataLibriCatalogo()
            }
            
        }else{
            HStack {
                //Pulsante che prende la forma della prima "Card"
                Button(action: funzionePrimaCard){
                    cardPrimi
                }
                .padding(10)
                .buttonStyle(PlainButtonStyle())
                .allowsHitTesting(show.wrappedValue ? false : true)
                
                Spacer()
                
                if cardSecondo.libro.isbn != ""{
                    //Pulsante che prende la forma della seconda "Card"
                    Button(action: funzioneSecondaCard){
                        cardSecondo
                    }
                    .padding(5)
                    .buttonStyle(PlainButtonStyle())
                    .allowsHitTesting(show.wrappedValue ? false : true)
                }
            }
        }
        
        
    }
}

/*
class PrendiData: ObservableObject{
    @Published var nPag = 0
    
    @Published var arrayLibri = NSMutableArray()
    
    @Published var arrayLibriRicerca = NSMutableArray()
    @Published var nPagRicerca = 0

    init() {
        updateData()
        //searchData(searchText: "")
    }
    
    func updateData(){
        
        GestioneJson().getPezziDelCatalogo(indiceCatalogo: String(nPag)) { connessione, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let connessione = connessione {
                    
                    if self.nPag == 0{
                        self.arrayLibri = connessione
                        
                    }else{
                        self.arrayLibri.addObjects(from: connessione as! [Any])
                    }
                    
                    self.nPag += 1
                } else {
                    print(error?.localizedDescription ?? "error libri")
                }
            }
        }
        
    }
    
    func searchData(searchText: String){
        GestioneJson().getLibroRicerca(ricercaTitoloLibro: searchText, ricercaCategorieLibro: NSMutableArray(object: "") ,indiceCatalogo: String(nPagRicerca)) { esitoLibri, errore in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let esitoLibri = esitoLibri {
                    
                    if self.nPagRicerca == 0{
                        self.arrayLibriRicerca = esitoLibri
                        
                    }else{
                        self.arrayLibriRicerca.addObjects(from: esitoLibri as! [Any])
                    }
                                        
                    self.nPagRicerca += 1
                } else {
                    print(errore?.localizedDescription ?? "error ricerca")
                }
            }
        }
    }
    
    func resetData(){
        nPag = 0
        arrayLibri = NSMutableArray()
    }
}
*/

private func inizializzaItem(index: Binding<Int>, CONST_INDEX_LIBRI: Int, datiLibro: Binding<MenuLibro>, showAnimationSecondary: Binding<Bool>, libriVisualizzazioneRichiestaJson: [DatiLibro], show: Binding<Bool>, searchData: Binding<String>) -> [ItemOrizzontaliLista]{
            
    var arrayTemp = [ItemOrizzontaliLista]()
    
    var item = ItemOrizzontaliLista(funzionePrimaCard: {}, funzioneSecondaCard: {},show: show, ultimoItem: false, getData: HttpManager(), searchText: searchData)
                    
    for i in stride(from: 0, to: libriVisualizzazioneRichiestaJson.count, by: 2) {
                        
        if i < libriVisualizzazioneRichiestaJson.count - 1 && i != libriVisualizzazioneRichiestaJson.count{
            item = ItemOrizzontaliLista(
                cardPrimi: CardLibri(libro: libriVisualizzazioneRichiestaJson[i]),
                cardSecondo: CardLibri(libro: libriVisualizzazioneRichiestaJson[i + 1]),
                funzionePrimaCard: {
                    index.wrappedValue = CONST_INDEX_LIBRI
                    datiLibro.wrappedValue = MenuLibro(datiLibro: libriVisualizzazioneRichiestaJson[i], index: index, showAnimationSecondary: showAnimationSecondary, show: show)
                    withAnimation { showAnimationSecondary.wrappedValue.toggle() }
                },
                funzioneSecondaCard: {
                    index.wrappedValue = CONST_INDEX_LIBRI
                    datiLibro.wrappedValue = MenuLibro(datiLibro: libriVisualizzazioneRichiestaJson[i + 1], index: index, showAnimationSecondary: showAnimationSecondary, show: show)
                    withAnimation { showAnimationSecondary.wrappedValue.toggle() }
                }, show: show, ultimoItem: false, getData: HttpManager(), searchText: searchData
            )
            
        }else if i == libriVisualizzazioneRichiestaJson.count - 1{
            item = ItemOrizzontaliLista(
                cardPrimi: CardLibri(libro: libriVisualizzazioneRichiestaJson[i]),
                cardSecondo: CardLibri(libro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "0", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil)),
                funzionePrimaCard: {
                    index.wrappedValue = CONST_INDEX_LIBRI
                    datiLibro.wrappedValue = MenuLibro(datiLibro: libriVisualizzazioneRichiestaJson[i], index: index, showAnimationSecondary: showAnimationSecondary, show: show)
                    withAnimation { showAnimationSecondary.wrappedValue.toggle() }
                },
                funzioneSecondaCard: {}, show: show, ultimoItem: false, getData: HttpManager(), searchText: searchData
            )
        }
        
        arrayTemp.append(item)

        
    }
        
    return arrayTemp
}

struct ListaVisualizzazione_Previews: PreviewProvider {
    static var previews: some View {
        ListaVisualizzazione(index: .constant(0), datiLibro: .constant(MenuLibro(datiLibro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil), index: .constant(0), showAnimationSecondary: .constant(false), show: .constant(false))), showAnimationSecondary: .constant(false), show: .constant(false))
    }
}
