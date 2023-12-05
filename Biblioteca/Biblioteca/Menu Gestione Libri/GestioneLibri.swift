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
    @ObservedObject var httpManager: HttpManager
    
    @State var indexMenu: Binding<Int>
    @State var datiLibro: Binding<DatiLibro>
    @State var showAnimationSecondary: Binding<Bool>
    @State var showAggiuntaLibro = false
    
    //Metodo costruttore
    init(httpManager: HttpManager = HttpManager(), indexMenu: Binding<Int>, datiLibro: Binding<DatiLibro>, showAnimationSeondary: Binding<Bool>) {
        self.httpManager = httpManager
        self.indexMenu = indexMenu
        self.datiLibro = datiLibro
        self.showAnimationSecondary = showAnimationSeondary
    }
    
    var body: some View {
        let arrayLibri = httpManager.arrayLibri as! [DatiLibro]
               
        if !showAggiuntaLibro{
            NavigationView{
                List {
                    ForEach(arrayLibri.indices, id: \.self) { index in
                        
                        //Se è l'ultimo item lo mette a "true", altrimente a "false"
                        if index == httpManager.arrayLibri.count - 1{
                            ItemGestioneLibro(
                                datiLibro: DatiLibro(isbn: arrayLibri[index].isbn,
                                 titolo: arrayLibri[index].titolo,
                                 sottotitolo: arrayLibri[index].sottotitolo,
                                 lingua: arrayLibri[index].lingua,
                                 casaEditrice: arrayLibri[index].casaEditrice,
                                 autore: arrayLibri[index].autore,
                                 annoPubblicazione: arrayLibri[index].annoPubblicazione,
                                 idCategorie: arrayLibri[index].idCategorie,
                                 idGenere: arrayLibri[index].idGenere,
                                 descrizione: arrayLibri[index].descrizione,
                                 np: arrayLibri[index].np, 
                                 image: arrayLibri[index].image),
                                isLast: true,
                                data: httpManager,
                                index: indexMenu,
                                datiLibroBinding: datiLibro,
                                showAnimationSecondary:
                                    showAnimationSecondary)
                            
                        }else{
                            ItemGestioneLibro(datiLibro: DatiLibro(isbn: arrayLibri[index].isbn, titolo: arrayLibri[index].titolo, sottotitolo: arrayLibri[index].sottotitolo, lingua: arrayLibri[index].lingua, casaEditrice: arrayLibri[index].casaEditrice, autore: arrayLibri[index].autore, annoPubblicazione: arrayLibri[index].annoPubblicazione, idCategorie: arrayLibri[index].idCategorie, idGenere: arrayLibri[index].idGenere, descrizione: arrayLibri[index].descrizione, np: arrayLibri[index].np, image: arrayLibri[index].image), data: httpManager, index: indexMenu, datiLibroBinding: datiLibro, showAnimationSecondary: showAnimationSecondary)
                        }
                    }
                }
                .refreshable(action: {
                    httpManager.resetDataCatalogo()
                    httpManager.refreshLibriCatalogo()
                })
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
            .onAppear {
                httpManager.resetDataCatalogo()
                httpManager.updateDataLibriCatalogo()
                //9788891639431
            }
            
        }else{
            aggiuntaLibro(showAggiuntaLibroBinding: $showAggiuntaLibro, dataList: httpManager)
        }
    }
}

struct aggiuntaLibro: View{
    @State var showAggiuntaLibroBinding: Binding<Bool>
    
    @ObservedObject var dataList: HttpManager
    
    @State var ricercaLibroIsbn = true
    
    //Variabile del TextField per la ricerca del libro dal ISBN
    @State var isbnLibro = ""
    
    init(showAggiuntaLibroBinding: Binding<Bool>, dataList: HttpManager) {
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
    @ObservedObject var prendiData: HttpManager
    
    var showAggiuntaLibroBinding: Binding<Bool>
    
    init(isbnLibro: String, prendiData: HttpManager = HttpManager(), showAggiuntaLibroBinding: Binding<Bool>) {
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
    
    @ObservedObject var prendiData: HttpManager
    
    var showAggiuntaLibroBinding: Binding<Bool>
    
    var datiLibro: DatiLibro
    
    @State var cambiaModo = false
            
    init(prendiData: HttpManager, showAggiuntaLibroBinding: Binding<Bool>, datiLibro: DatiLibro) {
        
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
                    .padding(.leading, 20)
                                    
                    VStack(alignment: .leading) {
                        Text("ISBN:")
                            .font(.subheadline)
                        
                        Text(datiLibro.isbn)
                            .foregroundColor(.primary.opacity(0.5))
                        
                    }
                }
            }
            .onAppear {
                prendiData.getTutteCategorie()
                prendiData.getTuttiGeneri()
            }
            
            NavigationView {
                Form{
                    Section("Info libro"){
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
                                .padding(.bottom)
                            
                            Text(String(datiLibro.np))
                        }
                    }
                    .headerProminence(.increased)
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                                            withAnimation(Animation.easeInOut(duration: 0.5)) {
                                                cambiaModo.toggle()
                                            }
                                            
                                        }){
                                            Text("Avanti")
                                        }
                )
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
                                  descrizioneLibro: datiLibro.descrizione ?? "Vuoto",
                                  numeroPagineLibro: String(datiLibro.np),
                                  immagineLibro: datiLibro.image ?? "", httpManager: prendiData, showAggiuntaLibroBilding: showAggiuntaLibroBinding)
        }
    }
}

struct ModificaAggiuntaLibro: View{
    
    private var datiLibro: DatiLibro
        
    private var httpManager: HttpManager
    
    @State private var showAlert = false
    @State private var showAlertTextField = false
    
    private var showAggiuntaLibroBilding: Binding<Bool>
        
    //Varaibili dei TextField per l'inserimento del libro nel DB
    @State var titoloLibro: String
    @State var sottotitoloLibro: String
    @State var linguaLibro: String
    @State var casaEditriceLibro: String
    @State var autoreLibro: String
    @State var annoPubblicazioneLibro: String
    
    @State var idCategorieLibro: String
    
    @State var idGenereLibro: String = ""
    
    @State var descrizioneLibro: String
    @State var numeroPagineLibro: String
    @State var immagineLibro: String
    
        
    @State private var condizioneCopiaLibro: CondizioneStato = .eccellenti
    
    @State var sezioneCopiaLibro = ""
    @State var scaffale = ""
    @State var ripianoCopiaLibro = ""
    
    @State var task: Task
            
    init(datiLibro: DatiLibro, titoloLibro: String, sottotitoloLibro: String, linguaLibro: String, casaEditriceLibro: String, autoreLibro: String, annoPubblicazioneLibro: String, idCategorieLibro: String, descrizioneLibro: String, numeroPagineLibro: String, immagineLibro: String, httpManager: HttpManager, showAggiuntaLibroBilding: Binding<Bool>) {
        
        self.datiLibro = datiLibro
        self.titoloLibro = titoloLibro
        self.sottotitoloLibro = sottotitoloLibro
        self.linguaLibro = linguaLibro
        self.casaEditriceLibro = casaEditriceLibro
        self.autoreLibro = autoreLibro
        self.annoPubblicazioneLibro = annoPubblicazioneLibro
        self.idCategorieLibro = idCategorieLibro
        self.descrizioneLibro = descrizioneLibro
        self.numeroPagineLibro = numeroPagineLibro
        self.immagineLibro = immagineLibro
        
        self.httpManager = httpManager
        self.showAggiuntaLibroBilding = showAggiuntaLibroBilding
        
        self.task = Task(name: "", servingGoals: [])
        
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
                .padding(.leading, 20)
                                
                VStack(alignment: .leading) {
                    Text("ISBN del libro: \n" + datiLibro.isbn)
                        .padding(.bottom, 115)
                }
            }
            
            NavigationView{
                Form{
                    Section("Info libro"){
                        LabelTextField(labelName: "Titolo", textFieldText: "Inserisci il titolo del libro", textState: $titoloLibro)
                        
                        LabelTextField(labelName: "Sottotitolo", textFieldText: "Inserisci il sottotitolo:", textState: $sottotitoloLibro)
                        
                        LabelTextField(labelName: "Lingua Libro", textFieldText: "Inserisci la lingua del libro:", textState: $linguaLibro)
                        
                        LabelTextField(labelName: "Casa editrice", textFieldText: "Inserisci la casa editrice del libro:", textState: $casaEditriceLibro)
                        
                        LabelTextField(labelName: "Autore del libro", textFieldText: "Inserisci l'autore del libro:", textState: $autoreLibro)
                        
                        LabelTextField(labelName: "Anno pubblicazione", textFieldText: "Inserisci l'anno di pubblicazione:", textState: $annoPubblicazioneLibro)
                                                
                        MultiSelector(
                            label: Text("Categorie:"),
                            options: generateGoals(categorie: httpManager.arrayCategorie),
                            optionToString: { $0.name },
                            selected: $task.servingGoals
                        )
                                                                                                
                        Picker("Genere:", selection: $idGenereLibro) {
                            
                            ForEach(0..<httpManager.arrayGeneri.count, id: \.self) { index in
                                Text((httpManager.arrayGeneri as! [String])[index])
                                    .tag(String(index + 1))
                            }
                             
                        }
                        
                        LabelTextField(labelName: "Descrizione", textFieldText: "Inserisci la descrizione del libro", textState: $descrizioneLibro)
                        
                        LabelTextField(labelName: "Numero di pagine", textFieldText: "Inserisci il numero di pagine del libro", textState: $numeroPagineLibro)
                    }
                    .headerProminence(.increased)
                    
                    Section("Sezione copia"){
                        //SEZIONE PER AGGIUNGERE COPIE
                        
                        Picker("Condizioni:", selection: $condizioneCopiaLibro) {
                            ForEach(CondizioneStato.allCases) { condizione in
                                Text(condizione.rawValue.capitalized)
                                    .tag(condizione.descrizione)
                            }
                        }
                        
                        LabelTextField(labelName: "Sezione", textFieldText: "Inserisci la sezione del libro", textState: $sezioneCopiaLibro)
                        
                        LabelTextField(labelName: "Scaffale", textFieldText: "Inserisci lo scaffale del libro", textState: $scaffale)
                        
                        LabelTextField(labelName: "Ripiano", textFieldText: "Inserisci il ripiano del libro", textState: $ripianoCopiaLibro)
                    }
                    .headerProminence(.increased)
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                                            //9788891639431
                                                                
                    httpManager.postLibro(datiLibrolibro: DatiLibro(isbn: datiLibro.isbn,
                                                                    titolo: titoloLibro,
                                                                    sottotitolo: sottotitoloLibro as String?,
                                                                    lingua: linguaLibro,
                                                                    casaEditrice: casaEditriceLibro as String?,
                                                                    autore: autoreLibro,
                                                                    annoPubblicazione: annoPubblicazioneLibro as String?,
                                                                    idCategorie: getIdItems(goalsDaOrdinare: task.servingGoals),
                                                                    idGenere:   Int32(idGenereLibro) ?? 0,
                                                                    descrizione: descrizioneLibro as String?,
                                                                    np: Int32(numeroPagineLibro) ?? 0,
                                                                    image: datiLibro.image))
                                            
                                            
                    httpManager.postCopiaLibro(copiaDelLibro: CopiaLibro(idCopia: 0,
                                                                         isbn: datiLibro.isbn,
                                                                         condizioni: condizioneCopiaLibro.rawValue,
                                                                         sezione: sezioneCopiaLibro,
                                                                         scaffale: Int32(scaffale) ?? 0,
                                                                         ripiano: Int32(ripianoCopiaLibro) ?? 0,
                                                                         idPrestito: -1))
                                            
                                            if !titoloLibro.isEmpty &&
                                                !sottotitoloLibro.isEmpty &&
                                                !linguaLibro.isEmpty &&
                                                !casaEditriceLibro.isEmpty &&
                                                !autoreLibro.isEmpty &&
                                                !annoPubblicazioneLibro.isEmpty &&
                                                !idCategorieLibro.isEmpty &&
                                                !idGenereLibro.isEmpty &&
                                                !numeroPagineLibro.isEmpty &&
                                                !condizioneCopiaLibro.rawValue.isEmpty &&
                                                !sezioneCopiaLibro.isEmpty &&
                                                !scaffale.isEmpty &&
                                                !ripianoCopiaLibro.isEmpty {
                                                
                                                withAnimation {
                                                    showAlertTextField = false
                                                    showAlert.toggle()
                                                }
                                                
                                            }else {
                                                showAlertTextField.toggle()
                                                showAlert.toggle()
                                            }
                                            
                                            
                                        }){
                                            Text("Carica")
                                        }
                                        .alert(isPresented: $showAlert, content: {
                                            Alert(
                                                title: Text(showAlertTextField ? "Errore" : "Caricamento"),
                                                message: Text(showAlertTextField ? "Il caricamento non è avvenuto, perché ci sono dei campi vuoti" : "Il caricamento è stato riuscito"),
                                                primaryButton: .default(Text("Avanti")) {
                                                    
                                                    if !showAlertTextField {
                                                        withAnimation {
                                                            showAggiuntaLibroBilding.wrappedValue.toggle()
                                                        }
                                                        
                                                    }else {
                                                        showAlert.toggle()
                                                    }
                                                    
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        })
                )
            }
        }
        .onAppear {
            self.idGenereLibro = "1"
            
            self.task = Task(name: "", servingGoals: [generateGoals(categorie: self.httpManager.arrayCategorie)[1]])
        }
    }
}

func generateGoals(categorie: NSMutableArray) -> [Goal] {
    
    let goals = categorie.enumerated().map { (index, element) in
        return Goal(name: element as! String, identificableNumber: String(index + 1))
    }
    
    return goals
}

func getIdItems(goalsDaOrdinare: Set<Goal>) -> String {
    var stringaStrutturata: String = ""
    
    for element in goalsDaOrdinare{
        
        if stringaStrutturata == "" {
            stringaStrutturata = element.identificableNumber
            
        }else {
            stringaStrutturata = stringaStrutturata + "," + element.identificableNumber
        }
    }
    
    return stringaStrutturata

}


@available(iOS 15.0, *)
struct ItemGestioneLibro: View{
    //Dichiarazione e inizializzazione delle due "Card" dove
    var datiLibro: DatiLibro
    
    var isLast = false
    
    var data: HttpManager
        
    var index: Binding<Int>
    var datiLibroBinding: Binding<DatiLibro>
    
    var showAnimationSecondary: Binding<Bool>
    
    init(datiLibro: DatiLibro, isLast: Bool = false, data: HttpManager, index: Binding<Int>, datiLibroBinding: Binding<DatiLibro>, showAnimationSecondary: Binding<Bool>) {
        
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
                            .font(.headline)
                            .padding(.top)
                        
                        Text(datiLibro.autore)
                            .font(.subheadline)
                        
                        Text(String(datiLibro.np))
                            .font(.footnote)
                            .padding(.bottom, 155/2)
                    }
                    .padding(.trailing, 10)
                    
                    Spacer()
                }
                .onAppear(){
                    data.updateDataLibriCatalogo()
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
                            .font(.headline)
                            .padding(.top)
                            
                        
                        Text(datiLibro.autore)
                            .font(.subheadline)
                        
                        Text(String(String(datiLibro.np)) + " pagine")
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

/*
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
                    self.datiLibro = datiLibro
                                                                                
                }else{
                    print(errore?.localizedDescription ?? "error")
                }
            }
        }
    }
}
 */

struct GestioneLibri_Previews: PreviewProvider {
    static var previews: some View {
        GestioneLibri(index: .constant(0), datiLibro: .constant(DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil)), showAnimationSecondary: .constant(false))
    }
}
