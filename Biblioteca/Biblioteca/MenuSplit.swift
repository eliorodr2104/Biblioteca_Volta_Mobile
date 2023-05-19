/**
 * Created by eliomar rodriguez on 22/03/23.
 *
 * Descrizione: Rappresenta una vista per la visualizzazione del menu. La struttura definisce alcune variabili di stato, tra cui index, che tiene traccia dell'azione
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
 * SwiftUI view MenuSplit.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

@available(iOS 15.0, *)
struct MenuSplit: View {
    
    //Variabile statica e privata con l'indice per i libri
    private let CONST_INDEX_LIBRI = 9
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    @State var animazioneCatalogo = false
    
    @State var index = 0
    @State var show: Bool
    @State var showAnimationSecondary: Bool
    
    @State var indexPrecedente = 0
    
    @State var datiLibro: MenuLibro
    @State var datiLibroGestione = DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil)

    private var nomeUtente: String
    var salutoUtente: String
    
    private var utenteUtilizzo: Utente
    
    init(index: Int = 0, show: Bool = false, showAnimationSecondary: Bool = false, nomeUtente: String, salutoUtente: String = "Bentornato", utenteUtilizzo: Utente, datiLibro: MenuLibro) {
        self.viewModel = ViewModel(utente: utenteUtilizzo)
        self.index = index
        self.show = show
        self.showAnimationSecondary = showAnimationSecondary
        self.nomeUtente = nomeUtente
        self.salutoUtente = salutoUtente
        self.utenteUtilizzo = utenteUtilizzo
        self.datiLibro = datiLibro
    }
    
    
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
                    VStack(alignment: .center){
                        ZStack{
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.white)
                            
                            Image(systemName: "xmark")
                                .cornerRadius(100)
                        }
                        .frame(width: 50, height: 50)
                        
                        
                        Text(salutoUtente)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.top, 5)
                        
                        Text(nomeUtente)
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                    .padding(.leading, 25)
                                        
                    //Pulsante per la visualizzazione del catalogo
                    Button(action: {
                        
                        self.indexPrecedente = 0
                        
                        //Indice di riconoscimento azione
                        self.index = 0
                        
                        //Fa lo switch della variabile di stato "show"
                        withAnimation{ self.show.toggle() }
                    }) {
                        HStack(spacing: 25){
                            Image("catalogue_icon")
                                .foregroundColor(self.index == 0 ? Color("ColorePrincipale") : Color.primary)
                                .frame(width: 5, height: 5)
                                
                            
                            Text("Catalogo")
                                .foregroundColor(self.index == 0 ? Color("ColorePrincipale") : Color.primary)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    .padding(.top,20)
                    
                    //Pulsante per la visualizzazione dei libri che sono in prestito
                    Button(action: {
                        
                        self.indexPrecedente = 1
                        
                        //Indice di riconoscimento azione
                        self.index = 1
                        
                        //Fa lo switch della variabile di stato "show"
                        withAnimation{ self.show.toggle() }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("libri_prestito")
                                .foregroundColor(self.index == 1 ? Color("ColorePrincipale") : Color.primary)
                                .frame(width: 5, height: 5)
                            
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
                        
                        self.indexPrecedente = 2
                        
                        //Indice di riconoscimento azione
                        self.index = 2
                        
                        //Fa lo switch della variabile di stato "show"
                        withAnimation{ self.show.toggle() }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("information_icon")
                                .foregroundColor(self.index == 2 ? Color("ColorePrincipale") : Color.primary)
                                .frame(width: 5, height: 5)
                            
                            
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
                        
                        self.indexPrecedente = 3
                        
                        //Indice di riconoscimento azione
                        self.index = 3
                        
                        //Fa lo switch della variabile di stato "show"
                        withAnimation{ self.show.toggle() }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("notification_icon")
                                .foregroundColor(self.index == 3 ? Color("ColorePrincipale") : Color.primary)
                                .frame(width: 5, height: 5)
                            
                            Text("Notifiche App")
                                .foregroundColor(self.index == 3 ? Color("ColorePrincipale") : Color.primary)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    if utenteUtilizzo.grado > 0 || utenteUtilizzo.grado < 4{
                        //Pulsante per la visualizzazione delle notifiche nell'app
                        Button(action: {
                            self.indexPrecedente = 5
                            
                            //Indice di riconoscimento azione
                            self.index = 5
                            
                            //Fa lo switch della variabile di stato "show"
                            withAnimation{ self.show.toggle() }
                            
                        }) {
                            HStack(spacing: 25){
                                Image("bookManagment_icon")
                                    .foregroundColor(self.index == 5 ? Color("ColorePrincipale") : Color.primary)
                                    .frame(width: 5, height: 5)
                                
                                Text("Gestione Libri")
                                    .foregroundColor(self.index == 5 ? Color("ColorePrincipale") : Color.primary)
                                
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 5 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                            .cornerRadius(10)
                            
                        }
                        
                        if utenteUtilizzo.grado == 2 || utenteUtilizzo.grado == 3{
                            //Pulsante per la visualizzazione delle notifiche nell'app
                            Button(action: {
                                
                                self.indexPrecedente = 6
                                
                                //Indice di riconoscimento azione
                                self.index = 6
                                
                                //Fa lo switch della variabile di stato "show"
                                withAnimation{ self.show.toggle() }
                                
                            }) {
                                HStack(spacing: 25){
                                    Image("loansManagment_icon")
                                        .foregroundColor(self.index == 6 ? Color("ColorePrincipale") : Color.primary)
                                        .frame(width: 5, height: 5)
                                    
                                    Text("Gestione Prestiti")
                                        .foregroundColor(self.index == 6 ? Color("ColorePrincipale") : Color.primary)
                                    
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 6 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                                
                            }
                            
                            //Pulsante per la visualizzazione delle notifiche nell'app
                            Button(action: {
                                
                                self.indexPrecedente = 7
                                
                                //Indice di riconoscimento azione
                                self.index = 7
                                
                                //Fa lo switch della variabile di stato "show"
                                withAnimation{ self.show.toggle() }
                                
                            }) {
                                HStack(spacing: 25){
                                    Image("analytics_icon")
                                        .foregroundColor(self.index == 7 ? Color("ColorePrincipale") : Color.primary)
                                        .frame(width: 5, height: 5)
                                    
                                    Text("Statistiche")
                                        .foregroundColor(self.index == 7 ? Color("ColorePrincipale") : Color.primary)
                                    
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 7 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                                
                            }
                        }
                        
                        if utenteUtilizzo.grado == 3{
                            //Pulsante per la visualizzazione delle notifiche nell'app
                            Button(action: {
                                
                                self.indexPrecedente = 8
                                
                                //Indice di riconoscimento azione
                                self.index = 8
                                
                                //Fa lo switch della variabile di stato "show"
                                withAnimation{ self.show.toggle() }
                                
                            }) {
                                HStack(spacing: 25){
                                    Image("developer_icon")
                                        .foregroundColor(self.index == 8 ? Color("ColorePrincipale") : Color.primary)
                                        .frame(width: 5, height: 5)
                                    
                                    Text("Debug")
                                        .foregroundColor(self.index == 8 ? Color("ColorePrincipale") : Color.primary)
                                    
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 8 ? Color("ColorePrincipale").opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                                
                            }
                        }
                    }
                    
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical, utenteUtilizzo.grado > 0 && utenteUtilizzo.grado < 4 ? 15 : 30)
                    
                    //Pulsante per la visualizzazione delle impostazioni dell'app
                    Button(action: {
                        
                        self.indexPrecedente = 4
                        
                        //Indice di riconoscimento azione
                        self.index = 4
                        
                        //Fa lo switch della variabile di stato "show"
                        withAnimation{ self.show.toggle() }
                        
                    }) {
                        HStack(spacing: 25){
                            Image("settings_icon")
                                .foregroundColor(self.index == 4 ? Color("ColorePrincipale") : Color.primary)
                                .frame(width: 5, height: 5)
                            
                            Text("Impostazioni")
                                .foregroundColor(self.index == 4 ? Color("ColorePrincipale") : Color.primary)
                            
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
            
            //Schermata di visualizzazione principale, la quale  mostra la lista di tutti i libri richiesti dal database
            VStack(spacing: 0){
                
                //Barra orizzontale la quale è nella posizone Top dello schermo, e ha il pulsante per tornare indetro
                HStack(spacing: 15){
                    
                    //Pulsante per la chiusura della schermata di visualizzazione principale con la lista dei libri
                    Button(action: {
                        
                        /*
                         * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è False quando
                         * viene modificata; al entrare avvia la funzione "toggle()", altrimenti, setta la variabile "index"
                         * uguale a zero e avvia la funzione "toggle()".
                         */
                        if !self.showAnimationSecondary{
                            withAnimation{ self.show.toggle() }
                            
                        }else{
                            self.index = self.indexPrecedente
                            
                            withAnimation{ self.showAnimationSecondary.toggle() }
                        }
                        
                    }) {
                        /*
                         * Struttura condizionale la quale controlla se la variabile di stato showAnimationSecondary è False quando
                         * viene modificata; al entrare controlla la variabile di stato "show" e cambia "Image", altrimenti,
                         * controlla la variabile di stato "showAnimationSecondary" e modifica "Image"
                         */
                        if !self.showAnimationSecondary{
                            Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                                .resizable()
                                .frame(width: self.show ? 18 : 22, height: 18)
                                .foregroundColor(Color.primary.opacity(0.4))
                            
                        }else{
                            Image(systemName: self.showAnimationSecondary ? "chevron.left" : "line.horizontal.3")
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
                                        (self.index == 4 ? "Impostazioni" :
                                            (self.index == 5 ? "Gestione Libri" :
                                                (self.index == 6 ? "Gestione Prestiti" :
                                                    (self.index == 7 ? "Statistiche" :
                                                        (self.index == 8 ? "Debug" : "Dati Libro")))))))))
                        .font(.title)
                        .foregroundColor(Color.primary.opacity(0.6))
                        
                    Spacer(minLength: 0)
                    
                }
                .padding()
                            
                //Lettura delle dimensioni dello schermo nel quale si avvia la app
                GeometryReader{_ in
                
                    //Visuale verticale nella quale c'è la lista del libri
                    VStack{
                        
                        //Cambia la visuale dipendendo dall'indice
                        if self.index == 0{
                            ListaVisualizzazione(index: $index, datiLibro: $datiLibro, showAnimationSecondary: $showAnimationSecondary, show: $show)
                                //.disabled(showAnimationSecondary)
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            if abs(value.translation.width) > abs(value.translation.height) {
                                                // Horizontal movement
                                                if value.translation.width > 0 {
                                                    // Scrolling from left to right
                                                    withAnimation {
                                                        self.show = true
                                                    }
                                                } else {
                                                    // Scrolling from right to left
                                                    withAnimation {
                                                        self.show = false
                                                    }
                                                }
                                            }
                                        }
                                )
                                .offset(x: self.animazioneCatalogo ? UIScreen.main.bounds.width : 0, y: 0)
                                .onAppear(){
                                    self.animazioneCatalogo = false
                                }
                            
                        } else if self.index == 1{
                            //Libri prestito
                            MenuPrestiti(listaPrestiti: viewModel.arrayPrestiti as! [Prestito])
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            if abs(value.translation.width) > abs(value.translation.height) {
                                                // Horizontal movement
                                                if value.translation.width > 0 {
                                                    // Scrolling from left to right
                                                    withAnimation {
                                                        self.show = true
                                                    }
                                                } else {
                                                    // Scrolling from right to left
                                                    withAnimation {
                                                        self.show = false
                                                    }
                                                }
                                            }
                                        }
                                )
                            
                        } else if self.index == 2{
                            //Informazioni()
                            
                        } else if self.index == 3{
                            
                        }else if self.index == 4{

                        }else if self.index == 5{
                            GestioneLibri(index: $index, datiLibro: $datiLibroGestione, showAnimationSecondary: $showAnimationSecondary)
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            if abs(value.translation.width) > abs(value.translation.height) {
                                                // Horizontal movement
                                                if value.translation.width > 0 {
                                                    // Scrolling from left to right
                                                    withAnimation {
                                                        self.show = true
                                                    }
                                                } else {
                                                    // Scrolling from right to left
                                                    withAnimation {
                                                        self.show = false
                                                    }
                                                }
                                            }
                                        }
                                )

                        }else if self.index == 6{
                            
                        }else if self.index == 7{
                            
                        }else if self.index == 8{
                            
                        }else if self.index == 9{
                            MenuGestioneLibro(datiLibro: datiLibroGestione)
                                .offset(x: self.showAnimationSecondary ? 0 : UIScreen.main.bounds.width, y: 0)
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            if abs(value.translation.width) > abs(value.translation.height) {
                                                // Horizontal movement
                                                if value.translation.width > 0 {
                                                    // Scrolling from left to right
                                                    index = 5
                                                    
                                                    withAnimation {
                                                        showAnimationSecondary = false
                                                        animazioneCatalogo = true
                                                    }
                                                }
                                            }
                                        }
                                )
                            
                        }else if self.index == 10{
                            MenuLibro(datiLibro: datiLibro.datiLibro, index: $index, showAnimationSecondary: $showAnimationSecondary, show: $show)
                                .background(Color(UIColor.systemBackground))
                                //Spostamento della vista a destra quando si fa clic sul pulsante del menu
                                .offset(x: self.showAnimationSecondary ? 0 : UIScreen.main.bounds.width, y: 0)
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            if abs(value.translation.width) > abs(value.translation.height) {
                                                // Horizontal movement
                                                if value.translation.width > 0 {
                                                    // Scrolling from left to right
                                                    index = 0
                                                    
                                                    withAnimation {
                                                        showAnimationSecondary = false
                                                        animazioneCatalogo = true
                                                    }
                                                }
                                            }
                                        }
                                )
                            
                        }
                        
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
            //Applica i bordi rotondi
            .cornerRadius(self.show ? 30 : 0)
            //Restringimento e spostamento della vista a destra quando si fa clic sul pulsante del menu
            .scaleEffect(self.show ? 0.9 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
            //Rotazione
            .rotationEffect(.init(degrees: self.show ? -5 : 0))
            .shadow(color: Color("ColorePrincipale"), radius: self.show ? 5 : 0)
        }
    }
}

@available(iOS 15.0, *)
extension MenuSplit {
    class ViewModel: ObservableObject {        
        @Published var arrayPrestiti = NSMutableArray()
        
        @Published var prova = ""
        
        init(utente: Utente) {
            GestioneJson().getPrestitiDellUtente(utente: utente){ prestito, errore in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let prestito = prestito {                        
                        self.arrayPrestiti = prestito
                        
                    }else {
                        //print(errore?.localizedDescription ?? "error")
                    }
                }
                
            }
            
            /*
            GestioneJson().postDatiLibro(libroDaCaricare: <#T##DatiLibro#>, ){ libro, errore in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if libro != nil {
                        self.prova = libro ?? "CIAO"
                        
                    }else {
                        //print(errore?.localizedDescription ?? "error")
                    }
                }
                
            }
             */
             
        }
    }
}

@available(iOS 15.0, *)
struct MenuSplit_Previews: PreviewProvider {
    static var previews: some View {
        MenuSplit(nomeUtente: "", utenteUtilizzo: Utente(idUtente: 0, nome: "", cognome: "", numero: nil, mailAlternativa: "", grado: 0, mail: "", preferiti: nil), datiLibro: MenuLibro(datiLibro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil), index: .constant(0), showAnimationSecondary: .constant(false), show: .constant(false)))
    }
}
