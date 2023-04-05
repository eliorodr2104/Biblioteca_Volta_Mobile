/**
 * Created by eliomar rodriguez on 23/03/23.
 *
 * Descrizione: Rappresenta una vista per la visualizzazione del menu su un tablet. La struttura definisce alcune variabili di stato, tra cui index, che tiene traccia dell'azione
 *          selezionata dall'utente, e showAnimationSecondary, che controlla se l'animazione per la visualizzazione del menu secondario deve essere eseguita. La struttura
 *          include anche la definizione di una variabile MenuLibro, utilizzata per visualizzare i dettagli di un libro selezionato.
 *
 *          Il corpo della vista è definito come una pila di z-stack e h-stack, utilizzati per definire la struttura e la posizione degli elementi all'interno del menu. La vista include
 *          pulsanti per visualizzare il catalogo dei libri, i libri in prestito, le informazioni dell'app e le notifiche dell'app. Il menu include anche un pulsante per accedere alle
 *          impostazioni dell'app.
 *
 *          La struttura di codice include anche alcuni stili e proprietà grafiche, come la dimensione del testo, il colore e la forma dei pulsanti, nonché la definizione di una
 *          divisione grafica tra i pulsanti principali e quelli per le impostazioni.
 *
 * Progetto: Biblioteca
 * SwiftUI view MenuSplitTablet.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

struct MenuSplitTablet: View {
    
    //Variabile statica e privata con l'indice per i libri
    private let CONST_INDEX_LIBRI = 5
    
    @State var index = 0
    
    @State var showAnimationSecondary = false
    
    @State var datiLibro: MenuLibro?
    
    var nomeUtente: String
    var salutoUtente: String
    
    
    var body: some View {
        ZStack{
            /*
             * Menù per la scelta dell'utente dentro l'app, il quale viene visualizzato con un'animazione; questa viene
             * controllata dalla variabile di stato "showAnimationSecondary", la quale quando viene modificata aggiorna la grafica
             * del programma inizialize, così mostrando i pulsanti di scelta.
             */
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    
                    //Immagine Profilo da mettere quando avrò l'icona del profilo
                    //Image(systemName: "xmark")
                    
                    Text(salutoUtente)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                    
                    Text(nomeUtente)
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.primary)
                    
                    //Pulsante per la visualizzazione del catalogo
                    Button(action: {
                        
                        //Indice di riconoscimento azione
                        self.index = 0
                        
                       /*
                        * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è True quando
                        * viene modificata; al entrare avvia la funzione "toggle()", così la setta di nuovo a false.
                        */
                        if self.showAnimationSecondary{
                            withAnimation{ self.showAnimationSecondary.toggle() }
                        }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("catalogo")
                                .foregroundColor(self.index == 0 ? Color("ColorePrincipale") : Color.primary)
                            
                            Text("Catalogo")
                                .foregroundColor(self.index == 0 ? Color("ColorePrincipale") : Color.primary)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
            
                    }
                    .padding(.top,25)
                    
                    //Pulsante per la visualizzazione dei libri che sono in prestito
                    Button(action: {
                        //Indice di riconoscimento azione
                        self.index = 1
                        
                       /*
                        * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è True quando
                        * viene modificata; al entrare avvia la funzione "toggle()", così la setta di nuovo a false.
                        */
                        if self.showAnimationSecondary{
                            withAnimation{ self.showAnimationSecondary.toggle() }
                        }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("libri prestito")
                                .foregroundColor(self.index == 1 ? Color("ColorePrincipale") : Color.primary)
                            
                            Text("Libri Prestito")
                                .foregroundColor(self.index == 1 ? Color("ColorePrincipale") : Color.primary)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    //Pulsante per la visualizzazione delle informazioni dell'utente
                    Button(action: {
                        //Indice di riconoscimento azione
                        self.index = 2
                        
                       /*
                        * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è True quando
                        * viene modificata; al entrare avvia la funzione "toggle()", così la setta di nuovo a false.
                        */
                        if self.showAnimationSecondary{
                            withAnimation{ self.showAnimationSecondary.toggle() }
                        }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("informazioni")
                                .foregroundColor(self.index == 2 ? Color("ColorePrincipale") : Color.primary)
                            
                            
                            Text("Informazioni")
                                .foregroundColor(self.index == 2 ? Color("ColorePrincipale") : Color.primary)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 2 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    //Pulsante per la visualizzazione delle notifiche nell'app
                    Button(action: {
                        //Indice di riconoscimento azione
                        self.index = 3
                        
                       /*
                        * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è True quando
                        * viene modificata; al entrare avvia la funzione "toggle()", così la setta di nuovo a false.
                        */
                        if self.showAnimationSecondary{
                            withAnimation{ self.showAnimationSecondary.toggle() }
                        }
                        
                        
                    }) {
                        HStack(spacing: 25){
                            Image("notifiche app")
                                .foregroundColor(self.index == 3 ? Color("ColorePrincipale") : Color.primary)
                            
                            Text("Notifiche App")
                                .foregroundColor(self.index == 3 ? Color("ColorePrincipale") : Color.primary)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical,30)
                    
                    //Pulsante per la visualizzazione delle impostazioni dell'app
                    Button(action: {
                        //Indice di riconoscimento azione
                        self.index = 4
                        
                       /*
                        * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è True quando
                        * viene modificata; al entrare avvia la funzione "toggle()", così la setta di nuovo a false.
                        */
                        if self.showAnimationSecondary{
                            withAnimation{ self.showAnimationSecondary.toggle() }
                        }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("impostazioni")
                                .foregroundColor(Color.primary)
                            
                            Text("Impostazioni")
                                .foregroundColor(Color.primary)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 4 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                        
                    }
                    Spacer(minLength: 0)
                    
                }
                .padding(.top,25)
                .padding(.horizontal,20)
                
                Spacer(minLength: 0)
                
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            //Schermata di visualizzazione principale, la quale  mostra la lista di tutti i libri richiesti dal database
            VStack(spacing: 0){
                
                //Barra orizzontale la quale è nella posizone Top dello schermo, e ha il pulsante per tornare indetro
                HStack(spacing: 15){
                    
                    //Pulsante per la chiusura della schermata di visualizzazione principale con la lista dei libri
                    Button(action: {
                        
                       /*
                        * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è True quando
                        * viene modificata; al entrare setta la variabile "index" uguale a zero e avvia la funzione "toggle()",
                        * così la setta di nuovo a false.
                        */
                        if self.showAnimationSecondary{
                            self.index = 0
                            
                            withAnimation{ self.showAnimationSecondary.toggle() }
                        }
                        
                    }) {
                       /*
                        * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è True quando
                        * viene modificata; al entrare modifica l'immagine del pulsante per tornare indietro
                        */
                        if self.showAnimationSecondary{
                            Image(systemName: self.showAnimationSecondary ? "chevron.left" : "")
                                .resizable()
                                .frame(width: self.showAnimationSecondary ? 18 : 22, height: 18)
                                .foregroundColor(Color.primary.opacity(0.4))
                        }
                        
                    }
                    
                    //Cambia il testo del pulsante dipendendo dall'indice che c'è nel momento del controllo
                    Text(self.index == 0 ? "Catalogo" :
                            (self.index == 1 ? "Libri Prestito" :
                                (self.index == 2 ? "Informazioni" :
                                    (self.index == 3 ? "Notifiche App" :
                                        (self.index == 4 ? "Impostazioni" : "Dati Libro")))))
                    .font(.title)
                    .foregroundColor(Color.primary.opacity(0.6))
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.horizontal, self.showAnimationSecondary ? 15 : 0)
                
                //Lettura delle dimensioni dello schermo nel quale si avvia la app
                GeometryReader{_ in
                    
                    //Visuale verticale nella quale c'è la lista del libri
                    VStack{
                        
                        //Array temp, il quale ha dei dati di prova, che dopo verranno presi da un file JSON
                        let tempArrayItemVisualizzazione = inizializzaItem(index: $index, CONST_INDEX_LIBRI: CONST_INDEX_LIBRI, datiLibro: $datiLibro, showAnimationSecondary: $showAnimationSecondary)

                        //Cambia la visuale dipendendo dall'indice
                        if self.index == 0{
                            ListaVisualizzazione(listaItemOrizzontale: tempArrayItemVisualizzazione)
                            
                        } else if self.index == 1{
                            
                            
                        } else if self.index == 2{
                            
                            
                        } else if self.index == 3{
                            
                        }else if self.index == 4{
                            
                        }else{
                            MenuLibro(titolo: datiLibro?.titolo, autore: datiLibro?.autore, numeroCopie: datiLibro?.numeroCopie ,disponibilitaLibro: datiLibro?.disponibilitaLibro)
                                .background(Color(UIColor.systemBackground))
                            //Spostamento della vista a destra quando si fa clic sul pulsante del menu
                            
                                .offset(x: self.showAnimationSecondary ? 0 : UIScreen.main.bounds.width, y: 0)
                            
                            //Animazione di slide
                                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
                        }
                        
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
            .cornerRadius(30)
            .shadow(color: Color("ColorePrincipale").opacity(0.50), radius: 5)
            .padding(.leading, 187)
        }
    }
}

private func inizializzaItem(index: Binding<Int>, CONST_INDEX_LIBRI: Int, datiLibro: Binding<MenuLibro?>, showAnimationSecondary: Binding<Bool>) -> [ItemOrizzontaliLista]{

    //Prova aggiunta libri json
    let libriVisualizzazioneRichiestaJson = inizializzaArrayLibro()
    
    var arrayTemp = [ItemOrizzontaliLista]()
    
    var item = ItemOrizzontaliLista(funzionePrimaCard: {}, funzioneSecondaCard: {})
            
    for i in stride(from: 0, to: libriVisualizzazioneRichiestaJson.count, by: 2) {
                
        if i < libriVisualizzazioneRichiestaJson.count - 1 && i != libriVisualizzazioneRichiestaJson.count{
            item = ItemOrizzontaliLista(
                cardPrimi: CardLibri(libro: libriVisualizzazioneRichiestaJson[i]),
                cardSecondo: CardLibri(libro: libriVisualizzazioneRichiestaJson[i + 1]),
                funzionePrimaCard: {
                    index.wrappedValue = CONST_INDEX_LIBRI
                    datiLibro.wrappedValue = MenuLibro(titolo: libriVisualizzazioneRichiestaJson[i].titolo, autore: libriVisualizzazioneRichiestaJson[i].autore, numeroCopie: libriVisualizzazioneRichiestaJson[i].nPag as? Int, disponibilitaLibro: false)
                    withAnimation { showAnimationSecondary.wrappedValue.toggle() }
                },
                funzioneSecondaCard: {
                    index.wrappedValue = CONST_INDEX_LIBRI
                    datiLibro.wrappedValue = MenuLibro(titolo: libriVisualizzazioneRichiestaJson[i + 1].titolo, autore: libriVisualizzazioneRichiestaJson[i + 1].autore, numeroCopie: libriVisualizzazioneRichiestaJson[i + 1].nPag as? Int, disponibilitaLibro: true)
                    withAnimation { showAnimationSecondary.wrappedValue.toggle() }
                }
            )
            
        }else if i == libriVisualizzazioneRichiestaJson.count - 1{
            item = ItemOrizzontaliLista(
                cardPrimi: CardLibri(libro: libriVisualizzazioneRichiestaJson[i]),
                cardSecondo: CardLibri(libro: Libro(isbn: "", titolo: "", lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, pathImmagine: "", nPag: nil, categoria: nil, copie: nil)),
                funzionePrimaCard: {
                    index.wrappedValue = CONST_INDEX_LIBRI
                    datiLibro.wrappedValue = MenuLibro(titolo: libriVisualizzazioneRichiestaJson[i].titolo, autore: libriVisualizzazioneRichiestaJson[i].autore, numeroCopie: libriVisualizzazioneRichiestaJson[i].nPag as? Int, disponibilitaLibro: false)
                    withAnimation { showAnimationSecondary.wrappedValue.toggle() }
                },
                funzioneSecondaCard: {}
            )
        }
        
        arrayTemp.append(item)
    }
    return arrayTemp
}

private func inizializzaArrayLibro() -> [Libro]{
    return [
        Libro (isbn: "",
                 titolo: "prova",
                 lingua: "",
                 casaEditrice: nil,
                 autore: "",
                 annoPubblicazione: nil,
                 pathImmagine: "",
                 nPag: nil,
                 categoria: nil,
                 copie: nil),
        
        Libro (isbn: "",
                 titolo: "prova 2",
                 lingua: "",
                 casaEditrice: nil,
                 autore: "",
                 annoPubblicazione: nil,
                 pathImmagine: "",
                 nPag: nil,
                 categoria: nil,
                 copie: nil),
        
        Libro (isbn: "",
                 titolo: "prova 3",
                 lingua: "",
                 casaEditrice: nil,
                 autore: "",
                 annoPubblicazione: nil,
                 pathImmagine: "",
                 nPag: nil,
                 categoria: nil,
                 copie: nil)
    ]
}

struct MenuSplitTablet_Previews: PreviewProvider {
    static var previews: some View {
        MenuSplitTablet(nomeUtente: "", salutoUtente: "")
    }
}
