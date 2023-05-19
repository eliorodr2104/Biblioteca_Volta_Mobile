//
//  GestioneLibri.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 10/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import sharedModuleBiblioteca
import CachedAsyncImage

struct GestioneLibri: View {
    
    @State var index: Binding<Int>
    @State var datiLibro: Binding<DatiLibro>
    @State var showAnimationSecondary: Binding<Bool>
        
    init(index: Binding<Int>, datiLibro: Binding<DatiLibro>, showAnimationSecondary: Binding<Bool>) {
        self.index = index
        self.datiLibro = datiLibro
        self.showAnimationSecondary = showAnimationSecondary
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ListaGestioneLibro(indexMenu: index, datiLibro: datiLibro, showAnimationSeondary: showAnimationSecondary)
            
        }
    }
}

@available(iOS 15.0, *)
struct ListaGestioneLibro: View {
    //Chiamata al server per la richiesta dei libri (10 alla volta)
    @ObservedObject var dataList: PrendiDatiLibri
    
    @State var indexMenu: Binding<Int>
    @State var datiLibro: Binding<DatiLibro>
    @State var showAnimationSecondary: Binding<Bool>
    @State var showAggiuntaLibro = false
    
    //Metodo costruttore
    init(dataList: PrendiDatiLibri = PrendiDatiLibri(), indexMenu: Binding<Int>, datiLibro: Binding<DatiLibro>, showAnimationSeondary: Binding<Bool>) {
        self.dataList = dataList
        self.indexMenu = indexMenu
        self.datiLibro = datiLibro
        self.showAnimationSecondary = showAnimationSeondary
    }
    
    var body: some View {
        let arrayLibri = dataList.arrayLibri as! [DatiLibro]
               
        if !showAggiuntaLibro{
            NavigationView{
                List {
                    ForEach(arrayLibri.indices, id: \.self) { index in
                        
                        //Se è l'ultimo item lo mette a "true", altrimente a "false"
                        if index == dataList.arrayLibri.count - 1{
                            ItemGestioneLibro(datiLibro: DatiLibro(isbn: arrayLibri[index].isbn, titolo: arrayLibri[index].titolo, sottotitolo: arrayLibri[index].sottotitolo, lingua: arrayLibri[index].lingua, casaEditrice: arrayLibri[index].casaEditrice, autore: arrayLibri[index].autore, annoPubblicazione: arrayLibri[index].annoPubblicazione, idCategorie: arrayLibri[index].idCategorie, idGenere: arrayLibri[index].idGenere, descrizione: arrayLibri[index].descrizione, np: arrayLibri[index].np, image: arrayLibri[index].image), isLast: true, data: dataList, index: indexMenu, datiLibroBinding: datiLibro, showAnimationSecondary: showAnimationSecondary)
                            
                        }else{
                            ItemGestioneLibro(datiLibro: DatiLibro(isbn: arrayLibri[index].isbn, titolo: arrayLibri[index].titolo, sottotitolo: arrayLibri[index].sottotitolo, lingua: arrayLibri[index].lingua, casaEditrice: arrayLibri[index].casaEditrice, autore: arrayLibri[index].autore, annoPubblicazione: arrayLibri[index].annoPubblicazione, idCategorie: arrayLibri[index].idCategorie, idGenere: arrayLibri[index].idGenere, descrizione: arrayLibri[index].descrizione, np: arrayLibri[index].np, image: arrayLibri[index].image), data: dataList, index: indexMenu, datiLibroBinding: datiLibro, showAnimationSecondary: showAnimationSecondary)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarItems(leading:
                                        HStack{
                    Text("Lista dei libri")
                        .font(.largeTitle)
                        .padding(.leading, 15)
                    
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showAggiuntaLibro.toggle()
                        }
                        
                    }){
                        ZStack{
                            if !showAggiuntaLibro{
                                Text("+")
                                    .font(.title)
                                    .foregroundColor(.primary)
                                
                            }else{
                                Text("-")
                                    .font(.title)
                                    .foregroundColor(.primary)
                            }
                            
                        }
                        .frame(width: 25, height: 25)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 10)

                }
                    .frame(width: UIScreen.main.bounds.width)
                )
            }
            
        }else{
            aggiuntaLibro(showAggiuntaLibroBinding: $showAggiuntaLibro, dataList: dataList)
        }
    }
}

struct aggiuntaLibro: View{
    @State var showAggiuntaLibroBinding: Binding<Bool>
    
    @ObservedObject var dataList: PrendiDatiLibri
    
    @State var ricercaLibroIsbn = true
    
    //Variabile del TextField per la ricerca del libro dal ISBN
    @State var isbnLibro = ""
    
    init(showAggiuntaLibroBinding: Binding<Bool>, dataList: PrendiDatiLibri) {
        self.showAggiuntaLibroBinding = showAggiuntaLibroBinding
        self.dataList = dataList
    }
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Aggiunta Libro")
                    .padding(.leading, 13)
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        showAggiuntaLibroBinding.wrappedValue.toggle()
                    }
                }){
                    Text("-")
                        .font(.title)
                        .foregroundColor(.primary)
                
                }
                .padding(.trailing, 19)
                .padding(.bottom, 1.5)
                
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.top, 6)
            
            Divider()
                .frame(width: UIScreen.main.bounds.width, height: 1)
                .background(Color.gray.opacity(0.3))
                .padding(.vertical, -13)
                .padding(.leading, 10)
            
            if ricercaLibroIsbn{
                VStack(alignment: .center) {
                    TextField("Inserisci ISBN del libro:", text: $isbnLibro)
                        .frame(width: 200)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.top, 15)
                        .keyboardType(.numberPad)
                    
                    Divider()
                        .frame(width: 200, height: 1)
                        .background(Color.gray.opacity(0.3))
                        .padding(.vertical, -1)
                    
                    HStack{
                        Button(action: {
                            withAnimation {
                                showAggiuntaLibroBinding.wrappedValue = false
                            }
                        }){
                            Text("Cancel")
                                .foregroundColor(Color.primary)
                        }
                        .padding(.top, 5)
                        
                        Divider()
                            .frame(width: 40, height: 25)

                        Button(action: {
                            ricercaLibroIsbn = false
                        }){
                            Text("Avanti")
                                .foregroundColor(Color.primary)
                        }
                        .padding(.top, 5)
                    }
                    .frame(width: 200)
                    .padding(.bottom, 12)
                }
                .background(Color("ColoreContrasto"))
                .cornerRadius(15)
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, (UIScreen.main.bounds.width/2)+20)
                .padding(.bottom, UIScreen.main.bounds.width/2)
                //.shadow(color: Color("ColorePrincipale"), radius: 5)
                //.animation(.default)
                
            }else{
                addLibro(isbnLibro: isbnLibro, showAggiuntaLibroBinding: showAggiuntaLibroBinding)
            }
        }
    }
}

struct addLibro: View{
    
    @State var isbnLibro: String
    @ObservedObject var prendiData: PrendiDatiLibri
    
    var showAggiuntaLibroBinding: Binding<Bool>
    
    init(isbnLibro: String, prendiData: PrendiDatiLibri = PrendiDatiLibri(), showAggiuntaLibroBinding: Binding<Bool>) {
        self.isbnLibro = isbnLibro
        self.prendiData = prendiData
        self.showAggiuntaLibroBinding = showAggiuntaLibroBinding
        
        prendiData.getLibroIsbn(isbn: isbnLibro)
        
    }
    
    var body: some View{
        let datiLibro = prendiData.datiLibro
        
        AggiuntaRicercaLibroApi(prendiData: prendiData,
                          showAggiuntaLibroBinding: showAggiuntaLibroBinding,
                          datiLibro: datiLibro)
    }
}

struct AggiuntaRicercaLibroApi: View{
    
    @ObservedObject var prendiData: PrendiDatiLibri
    
    var showAggiuntaLibroBinding: Binding<Bool>
    
    var datiLibro: DatiLibro
    
    @State var cambiaModo = false
            
    init(prendiData: PrendiDatiLibri, showAggiuntaLibroBinding: Binding<Bool>, datiLibro: DatiLibro) {
        
        self.prendiData = prendiData
        self.showAggiuntaLibroBinding = showAggiuntaLibroBinding
        self.datiLibro = datiLibro
    }
    
    var body: some View{
        if !cambiaModo{
            VStack(alignment: .leading) {
                HStack{
                    CachedAsyncImage(url: URL(string: datiLibro.image ?? "")){ image in
                        image.resizable(resizingMode: .stretch)
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 113, height: 175)
                                    
                    VStack(alignment: .leading) {
                        Text("ISBN del libro: \n" + datiLibro.isbn)
                            .padding(.bottom, 115)
                    }
                }
            }
            
            Form{
                VStack(alignment: .leading){
                    Text("Titolo")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(datiLibro.titolo)
                }
                
                VStack(alignment: .leading){
                    Text("Sottotitolo")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(datiLibro.sottotitolo ?? "Vuoto")
                }
                
                VStack(alignment: .leading){
                    Text("Lingua")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(datiLibro.lingua)
                }
                
                VStack(alignment: .leading){
                    Text("Casa editrice")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(datiLibro.casaEditrice ?? "Vuoto")
                }
                                
                VStack(alignment: .leading){
                    Text("Autore")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(datiLibro.autore)
                }
                
                VStack(alignment: .leading){
                    Text("Anno pubblicazione")
                        .font(.headline)
                        .padding(.bottom,6)
                    
                    Text(datiLibro.annoPubblicazione ?? "Vuoto")
                }
                
                //Cambiare a ComboBox
                VStack(alignment: .leading){
                    Text("Categorie")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(datiLibro.idCategorie)
                }
                
                //Cambiare a ComboBox
                VStack(alignment: .leading){
                    Text("Genere")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(String(datiLibro.idGenere))
                }
                
                //COPIE DA AGGIUNGERE
                VStack(alignment: .leading){
                    Text("Descrizione")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(datiLibro.descrizione ?? "Vuoto")
                }
                
                VStack(alignment: .leading){
                    Text("Numero pagine")
                        .font(.headline)
                        .padding(.bottom, 6)
                    
                    Text(String(datiLibro.np))
                }
            }
            
        }else{
            ModificaAggiuntaLibro(datiLibro: datiLibro,
                                  titoloLibro: datiLibro.titolo,
                                  sottotitoloLibro: datiLibro.sottotitolo ?? "Vuoto",
                                  linguaLibro: datiLibro.lingua,
                                  casaEditriceLibro: datiLibro.casaEditrice ?? "Vuoto",
                                  autoreLibro: datiLibro.autore,
                                  annoPubblicazioneLibro: datiLibro.annoPubblicazione ?? "Vuoto",
                                  idCategorieLibro: datiLibro.idCategorie,
                                  idGenereLibro: String(datiLibro.idGenere),
                                  descrizioneLibro: datiLibro.descrizione ?? "Vuoto",
                                  numeroPagineLibro: String(datiLibro.np),
                                  immagineLibro: datiLibro.image ?? "")
        }
        
        
        
        Button(action: {
            cambiaModo.toggle()
            
        }){
            Text("WEUWEU")
        }
    }
}

struct ModificaAggiuntaLibro: View{
    private var datiLibro: DatiLibro
    
    //Varaibili dei TextField per l'inserimento del libro nel DB
    @State var titoloLibro: String
    @State var sottotitoloLibro: String
    @State var linguaLibro: String
    @State var casaEditriceLibro: String
    @State var autoreLibro: String
    @State var annoPubblicazioneLibro: String
    @State var idCategorieLibro: String
    @State var idGenereLibro: String
    @State var descrizioneLibro: String
    @State var numeroPagineLibro: String
    @State var immagineLibro: String
    
    init(datiLibro: DatiLibro, titoloLibro: String, sottotitoloLibro: String, linguaLibro: String, casaEditriceLibro: String, autoreLibro: String, annoPubblicazioneLibro: String, idCategorieLibro: String, idGenereLibro: String, descrizioneLibro: String, numeroPagineLibro: String, immagineLibro: String) {
        
        self.datiLibro = datiLibro
        self.titoloLibro = titoloLibro
        self.sottotitoloLibro = sottotitoloLibro
        self.linguaLibro = linguaLibro
        self.casaEditriceLibro = casaEditriceLibro
        self.autoreLibro = autoreLibro
        self.annoPubblicazioneLibro = annoPubblicazioneLibro
        self.idCategorieLibro = idCategorieLibro
        self.idGenereLibro = idGenereLibro
        self.descrizioneLibro = descrizioneLibro
        self.numeroPagineLibro = numeroPagineLibro
        self.immagineLibro = immagineLibro
    }
    
    var body: some View{
        VStack(alignment: .leading) {
            HStack{
                CachedAsyncImage(url: URL(string: datiLibro.image ?? "")){ image in
                    image.resizable(resizingMode: .stretch)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 113, height: 175)
                                
                VStack(alignment: .leading) {
                    Text("ISBN del libro: \n" + datiLibro.isbn)
                        .padding(.bottom, 115)
                }
            }
            
            Form{
                LabelTextField(labelName: "Titolo", textFieldText: "Inserisci il titolo del libro", textState: $titoloLibro)
                
                LabelTextField(labelName: "Sottotitolo", textFieldText: "Inserisci il sottotitolo:", textState: $sottotitoloLibro)
                
                LabelTextField(labelName: "Lingua Libro", textFieldText: "Inserisci la lingua del libro:", textState: $linguaLibro)
                
                LabelTextField(labelName: "Casa editrice", textFieldText: "Inserisci la casa editrice del libro:", textState: $casaEditriceLibro)
                
                LabelTextField(labelName: "Autore del libro", textFieldText: "Inserisci la lingua del libro:", textState: $autoreLibro)
                
                LabelTextField(labelName: "Anno pubblicazione", textFieldText: "Inserisci l'anno di pubblicazione:", textState: $annoPubblicazioneLibro)
                
                //Cambiare a ComboBox
                
                LabelTextField(labelName: "Categorie", textFieldText: "Inserisci le categorie del libro:", textState: $idCategorieLibro)
                
                //Cambiare a ComboBox
                
                LabelTextField(labelName: "Genere", textFieldText: "Inserisci il genere del libro:", textState: $idGenereLibro)
                
                //COPIE DA AGGIUNGERE
                
                LabelTextField(labelName: "Descrizione", textFieldText: "Inserisci la descrizione del libro", textState: $descrizioneLibro)
                
                LabelTextField(labelName: "Numero di pagine", textFieldText: "Inserisci il numero di pagine del libro", textState: $numeroPagineLibro)
            }
            .navigationTitle("Modifica Libro")
        }
    }
}

@available(iOS 15.0, *)
struct ItemGestioneLibro: View{
    //Dichiarazione e inizializzazione delle due "Card" dove
    var datiLibro: DatiLibro
    
    var isLast = false
    
    var data: PrendiDatiLibri
        
    var index: Binding<Int>
    var datiLibroBinding: Binding<DatiLibro>
    
    var showAnimationSecondary: Binding<Bool>
    
    init(datiLibro: DatiLibro, isLast: Bool = false, data: PrendiDatiLibri, index: Binding<Int>, datiLibroBinding: Binding<DatiLibro>, showAnimationSecondary: Binding<Bool>) {
        
        self.datiLibro = datiLibro
        self.isLast = isLast
        self.data = data
        self.index = index
        self.datiLibroBinding = datiLibroBinding
        self.showAnimationSecondary = showAnimationSecondary
    }
        
    var body: some View {
        
        Button(action: {
            datiLibroBinding.wrappedValue = datiLibro
            index.wrappedValue = 9
            
            withAnimation{ showAnimationSecondary.wrappedValue.toggle() }
        }){
            if isLast{
                HStack {
                    ZStack{
                        CachedAsyncImage(url: URL(string: datiLibro.image ?? "")){ image in
                            image.resizable(resizingMode: .stretch)
                        } placeholder: {
                            //ProgressView()
                            Color.black
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 155/2, height: 250/2)
                        
                    }
                    .frame(width: 155/2, height: 250/2)
                    .padding(.leading, 10)
                    
                    VStack(alignment: .leading) {
                        
                        Text(datiLibro.titolo)
                            .font(.title)
                            .padding(.top)
                        
                        Text(datiLibro.autore)
                            .font(.body)
                        
                        Text(String(datiLibro.np))
                            .font(.footnote)
                            .padding(.bottom, 155/2)
                    }
                    .padding(.trailing, 10)
                    
                    Spacer()
                }
                .onAppear(){
                    data.updateData()
                }
                .background(Color(UIColor.systemBackground))
                
            }else{
                HStack {
                    ZStack{
                        CachedAsyncImage(url: URL(string: datiLibro.image ?? "")){ image in
                            image.resizable(resizingMode: .stretch)
                        } placeholder: {
                            //ProgressView()
                            Color.black
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 155/2, height: 250/2)
                        
                    }
                    .frame(width: 155/2, height: 250/2)
                    .padding(.leading, 10)
                    
                    VStack(alignment: .leading) {
                        Text(datiLibro.titolo)
                            .font(.title)
                            .padding(.top)
                            
                        
                        Text(datiLibro.autore)
                            .font(.body)
                        
                        Text(String("Numero pagine: " + String(datiLibro.np)))
                            .font(.footnote)
                            .padding(.bottom, 155/2)
                    }
                    .padding(.trailing, 10)
                    
                    Spacer()
                }
                .background(Color(UIColor.systemBackground))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

class PrendiDatiLibri: ObservableObject{
    @Published var nPagCatalogo = 0
    
    @Published var arrayLibri = NSMutableArray()
    
    @Published var datiLibro = DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil)
        
    init() {
        updateData()
    }
    
    func updateData(){
        GestioneJson().getPezziDelCatalogo(indiceCatalogo: String(nPagCatalogo)) { connessione, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                if let connessione = connessione {
                    if self.nPagCatalogo == 0{
                        self.arrayLibri = connessione
                        
                    }else{
                        self.arrayLibri.addObjects(from: connessione as! [Any])
                    }
                    
                    self.nPagCatalogo += 1
                } else {
                    print(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
    func getLibroIsbn(isbn: String){
        GestioneJson().getLibroApi(isbn: isbn) { datiLibro, errore in
            DispatchQueue.main.asyncAfter(deadline: .now() + -1){
                if let datiLibro = datiLibro{
                    //print(datiLibro)
                    
                    self.datiLibro = datiLibro
                    
                    //print(self.datiLibro)
                                        
                    //print(self.datiLibro)
                    
                }else{
                    print(errore?.localizedDescription ?? "error")
                }
            }
        }
    }
}

struct GestioneLibri_Previews: PreviewProvider {
    static var previews: some View {
        GestioneLibri(index: .constant(0), datiLibro: .constant(DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil)), showAnimationSecondary: .constant(false))
    }
}
