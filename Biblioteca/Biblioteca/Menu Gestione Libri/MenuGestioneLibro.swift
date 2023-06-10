//
//  MenuGestioneLibro.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 10/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import sharedModuleBiblioteca
import CachedAsyncImage

struct MenuGestioneLibro: View {
    @State private var textFieldCondizioni = ""
    @State private var textFieldSezione = ""
    @State private var textFieldScaffale = ""
    @State private var textFieldRipiano = ""

    @State private var ricaricaGrafica = true
    
    @State var datiLibro: DatiLibro
    
    @State var index = 0

    @State var showAggiuntaCopia = false
    
    @ObservedObject var dataList: PrendiDatiCopiaLibri
                
    init(datiLibro: DatiLibro) {
        self.datiLibro = datiLibro
        self.dataList = PrendiDatiCopiaLibri(isbn: datiLibro.isbn, idCategorie: datiLibro.idCategorie)
    }
    
    //Variabile di stato booleana
    @State var controlloDimensione = false
        
    var body: some View {
        let items: [Etichetta] = inizializzaCategorie(arrayCategorie: dataList.arrayCategorie as! [String])

        let nCopieDisponibili = getRisultatoCopie(copieLibro: dataList.libro.copie as? [CopiaLibro])
        
        let arrayLibri = dataList.libro.copie as? [CopiaLibro] ?? []
        
        //let condizioni = GestioneRisorseKt.leggereCondizioniLibro() as! [String]
        
        if index == 0{
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
                                CachedAsyncImage(url: URL(string: datiLibro.image ?? "")){ image in
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
                                            .frame(width: 16, height: 14)
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
                            
                            if !showAggiuntaCopia{
                                /*
                                 * Visualizzazione verticale la quale si mettono tutti i "Text" con le informazioni principali del libro,
                                 * fa anche un ulteriore controllo per la dimensione del testo con la variabile statica "isLargeSize"
                                 */
                                VStack(alignment: .leading) {
                                    
                                    Text(datiLibro.titolo)
                                        .fontWeight(.bold)
                                        .font(isLargeSize ? .largeTitle : .title)
                                        .foregroundColor(.primary)
                                        .padding(.top, 55)
                                    
                                    //DA MODIFICARE CON L'AUTORE DEL LIBRO ANZI CHE L'ID
                                    Text(String(datiLibro.autore) == "" ? "Autore sconosciuto" : String(datiLibro.autore ))
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
                                
                            }else{
                                VStack(alignment: .leading){
                                    Text("Aggiunta copie:")
                                        .padding(.leading, 10)
                                        .padding(.bottom, -1.2)
                                        .font(.headline)
                                    
                                    VStack(alignment: .leading){
                                        TextField("Condizioni", text: $textFieldCondizioni)
                                            .frame(width: 175, height: 25)
                                            .font(.system(size: 20))
                                            .padding(.leading, 10)
                                            .padding(.top, 10)
                                        
                                        Divider()
                                            .frame(width: 165, height: 1)
                                            .background(Color.white)
                                            .padding(.vertical, 0)
                                            .padding(.leading, 10)
                                        
                                        TextField("Sezione", text: $textFieldSezione)
                                            .frame(width: 175, height: 25)
                                            .font(.system(size: 20))
                                            .padding(.leading, 10)
                                        
                                        Divider()
                                            .frame(width: 165, height: 1)
                                            .background(Color.white)
                                            .padding(.vertical, 1)
                                            .padding(.leading, 10)
                                                                            
                                        TextField("Scaffale", text: $textFieldScaffale)
                                            .frame(width: 175, height: 25)
                                            .font(.system(size: 20))
                                            .keyboardType(.numberPad)
                                            .padding(.leading, 10)
                                        
                                        Divider()
                                            .frame(width: 165, height: 1)
                                            .background(Color.white)
                                            .padding(.vertical, 1)
                                            .padding(.leading, 10)
                                        
                                        TextField("Ripiano", text: $textFieldRipiano)
                                            .frame(width: 175, height: 25)
                                            .font(.system(size: 20))
                                            .keyboardType(.numberPad)
                                            .padding(.leading, 10)
                                            .padding(.bottom, 7)
                                    }
                                    .background(Color("ColoreContrasto"))
                                    .cornerRadius(15)
                                    .shadow(color: Color("ColorePrincipale") ,radius: 4)
                                }
                                .padding(.leading, 40)
                                .animation(.easeInOut(duration: 0.1), value: showAggiuntaCopia) // Imposta una durata più breve per l'animazione
                                .transition(.move(edge: .trailing))
                            }
                        }
                        
                        
                        Divider()
                            .background(Color.white)
                            .padding(.vertical, 11)
                        
                        if dataList.libro.idCategorie != ""{
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
                        }
                        
                        NavigationView{
                            List {
                                ForEach(arrayLibri.indices, id: \.self) { index in
                                    
                                    //Se è l'ultimo item lo mette a "true", altrimente a "false"
                                    if index == (dataList.libro.copie!.count) - 1{
                                        ItemGestioneCopiaLibro(datiLibro: CopiaLibro(idCopia: arrayLibri[index].idCopia , isbn: arrayLibri[index].isbn , condizioni: arrayLibri[index].condizioni , sezione: arrayLibri[index].sezione, scaffale: arrayLibri[index].scaffale , ripiano: arrayLibri[index].ripiano , idPrestito: arrayLibri[index].idPrestito ), data: dataList, index: $index, datiLibroBinding: $datiLibro, ricaricaPaginaBinding: $ricaricaGrafica)
                                        
                                    }else{
                                        ItemGestioneCopiaLibro(datiLibro: CopiaLibro(idCopia: arrayLibri[index].idCopia , isbn: arrayLibri[index].isbn, condizioni: arrayLibri[index].condizioni , sezione: arrayLibri[index].sezione, scaffale: arrayLibri[index].scaffale , ripiano: arrayLibri[index].ripiano, idPrestito: arrayLibri[index].idPrestito ), data: dataList, index: $index, datiLibroBinding: $datiLibro, ricaricaPaginaBinding: $ricaricaGrafica)
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .onChange(of: ricaricaGrafica, perform: { newValue in
                                dataList.updateData()
                            })
                            .refreshable {
                                dataList.updateData()
                            }
                            .navigationBarItems(leading:
                                                    HStack{
                                Text("Copie")
                                    .font(.largeTitle)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                
                                Button(action: {
                                    if showAggiuntaCopia && textFieldCondizioni != "" && textFieldSezione != ""{
                                        dataList.postCopiaLibro(copiaDelLibro: CopiaLibro(idCopia: 0, isbn: datiLibro.isbn, condizioni: textFieldCondizioni, sezione: textFieldSezione != "" ? textFieldSezione : nil, scaffale: Int32(textFieldScaffale) ?? 0, ripiano: Int32(textFieldRipiano) ?? 0, idPrestito: -1))
                                        
                                        textFieldCondizioni = ""
                                        textFieldSezione = ""
                                        textFieldScaffale = ""
                                        textFieldRipiano = ""
                                                                                
                                    }
                                    withAnimation {
                                        showAggiuntaCopia.toggle()
                                    }
                                    
                                    self.ricaricaGrafica.toggle()
                                    
                                }){
                                    ZStack{
                                        if !showAggiuntaCopia{
                                            Text("+")
                                                .font(.title)
                                                .foregroundColor(.primary)
                                            
                                        }else if textFieldCondizioni != "" && textFieldSezione != ""{
                                            
                                            RoundedRectangle(cornerRadius: 7)
                                                .fill(Color.green)
                                                .shadow(color: Color.green, radius: 5)
                                                .frame(width: 25, height: 30)
                                            
                                            Image(systemName: "chevron.right")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .foregroundColor(Color.primary)
                                            
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
                    }
                }
            }
            
        }else{
            
        }
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
struct ItemGestioneCopiaLibro: View{
    @State var showAlert = false
    
    var copiaDelLibro: CopiaLibro
        
    var data: PrendiDatiCopiaLibri
        
    var index: Binding<Int>
    var datiLibroBinding: Binding<DatiLibro>
    
    var ricaricaPaginaBinding: Binding<Bool>
    
    init(datiLibro: CopiaLibro, data: PrendiDatiCopiaLibri, index: Binding<Int>, datiLibroBinding: Binding<DatiLibro>, ricaricaPaginaBinding: Binding<Bool>) {
        self.copiaDelLibro = datiLibro
        self.data = data
        self.index = index
        self.datiLibroBinding = datiLibroBinding
        self.ricaricaPaginaBinding = ricaricaPaginaBinding
    }
        
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(datiLibroBinding.wrappedValue.titolo)
                    .font(.title)
                    .padding(.top)
                
                
                Text(datiLibroBinding.wrappedValue.autore)
                    .font(.body)
                
                Text("L'ID della copia è: " + String(copiaDelLibro.idCopia))
                    .font(.footnote)
            }
            .padding(.trailing, 10)
            
            Spacer()
            
            Button(action: {
                //ELIMINA LIBRO
                showAlert = true
            }){
                VStack(alignment: .center) {
                    Text("Elimina")
                        .font(.title2)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .foregroundColor(.primary)
                }
                .background(Color("ColorePrincipale").opacity(0.6))
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 10)
            .alert(isPresented: $showAlert) {
                        Alert(title: Text("Attenzione"),
                              message: Text("Vuoi continuare?"),
                              primaryButton: .default(Text("Continua")) {
                            //ELIMINA LIBRO da eseguire se l'utente sceglie "Continua"
                                                        
                            withAnimation {
                                data.deleteCopia(idCopiaDelete: String(copiaDelLibro.idCopia))
                            }
                            
                            self.ricaricaPaginaBinding.wrappedValue.toggle()
                        },
                              secondaryButton: .cancel(){
                            showAlert = false
                        })
                    }
        }
    }
}

class PrendiDatiCopiaLibri: ObservableObject{
    @Published var libro = Libro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, copie: nil, descrizione: nil, np: 0, image: nil)
    
    @Published var esito = ""
    
    @Published var arrayCategorie = NSMutableArray()
    
    var isbn: String
    var idCategorie: String
    
    init(isbn: String, idCategorie: String) {
        self.isbn = isbn
        self.idCategorie = idCategorie
        
        updateData()
        getCategorieLibro()
    }
    
    func updateData(){
        GestioneJson().getCopieLibroDaIsbn(isbn: isbn) { libro, error in
            DispatchQueue.main.async() {
                if let libro = libro {
                    self.libro = libro
                    
                } else {
                    //print(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
    func deleteCopia(idCopiaDelete: String){
        GestioneJson().deleteSingolaCopia(idCopia: idCopiaDelete) { esitoDelete, errore in
            DispatchQueue.main.async {
                if let esitoDelete = esitoDelete{
                    self.esito = esitoDelete
                    
                }else{
                    
                }
            }
        }
    }
    
    func getCategorieLibro(){
        GestioneJson().getCategorieLibro(listaIdCategoria: idCategorie) { arrayCategorie, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                if let arrayCategorie = arrayCategorie {
                    
                    self.arrayCategorie = arrayCategorie
                                        
                } else {
                    //print(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
    func postCopiaLibro(copiaDelLibro: CopiaLibro){
        GestioneJson().postCopiaLibro(copiaDaCaricare: copiaDelLibro) { risultato, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if let risultato = risultato {
                    self.esito = risultato
                    
                } else {
                    //print(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
}

struct MenuGestioneLibro_Previews: PreviewProvider {
    static var previews: some View {
        MenuGestioneLibro(datiLibro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil))
    }
}
