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
    @State private var pickerCondizioni: CondizioneStato = .eccellenti
    
    @State private var textFieldSezione = ""
    @State private var textFieldScaffale = ""
    @State private var textFieldRipiano = ""

    @State private var ricaricaGrafica = true
    
    @State var datiLibro: DatiLibro
    
    @State var index = 0

    @State var showAggiuntaCopia = false
    
    @ObservedObject var httpManager = HttpManager()
                
    init(datiLibro: DatiLibro) {
        self.datiLibro = datiLibro
        //self.dataList = PrendiDatiCopiaLibri(isbn: datiLibro.isbn, idCategorie: datiLibro.idCategorie)
    }
    
    //Variabile di stato booleana
    @State var controlloDimensione = false
        
    var body: some View {
        
        //let condizioni = GestioneRisorseKt.leggereCondizioniLibro() as! [String]
        
        if index == 0{
            //Lettura delle dimensioni dello schermo nel quale si avvia la app
            GeometryReader { geometry in
                
                //Variabile statica booleana, la quale controlla se la dimensione dello schermo è maggiore o uguale a 700
                let isLargeSize = geometry.size.width >= 700
                
                //Corpo della schermata
                ZStack {
                    let items: [Etichetta] = inizializzaCategorie(arrayCategorie: httpManager.arrayCategorie as! [String])

                    let nCopieDisponibili = getRisultatoCopie(copieLibro: httpManager.libro?.copie as? [CopiaLibro])
                    
                    let arrayLibri = httpManager.libro?.copie as? [CopiaLibro] ?? []
                    
                    //Visualizazzione verticale la quale mostra i elementi allineati a sinistra dello schermo
                    VStack(alignment: .leading){
                        
                        //Visualizzazione orizzontale dove ci sono le informazioni principale del libro anche con l'immagine
                        HStack(alignment: .center){
                            
                            //Corpo del rettangolo che ha la copertina del libro
                            ZStack{
                                CachedAsyncImage(url: URL(string: datiLibro.image ?? "")){ image in
                                    image.resizable(resizingMode: .stretch)
                                } placeholder: {
                                    //Color.red
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
                                .padding(.leading, 10)
                                
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
                                    
                                    Text("La lingua è: " + GestioneRisorseKt.conversioneLinguaLibro(linguaDelLibro: datiLibro.lingua ))
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
                                        Picker("", selection: $pickerCondizioni) {
                                            ForEach(CondizioneStato.allCases) { condizione in
                                                Text(condizione.rawValue.capitalized)
                                                    .tag(condizione.descrizione)
                                                    
                                            }
                                        }
                                        .frame(width: 175, height: 25)
                                        .font(.system(size: 15))
                                        .padding(.leading, 10)
                                        .padding(.top, 10)
                                        
                                        
                                        Divider()
                                            .frame(width: 185, height: 0.5)
                                            .background(Color("ColoreDividerContrasto"))
                                            .padding(.leading, 10)
                                            
                                        TextField("Sezione", text: $textFieldSezione)
                                            .frame(width: 175, height: 25)
                                            .font(.system(size: 17))
                                            .padding(.leading, 10)
                                        
                                        Divider()
                                            .frame(width: 185, height: 0.5)
                                            .background(Color("ColoreDividerContrasto"))
                                            .padding(.leading, 10)

                                              
                                        TextField("Scaffale", text: $textFieldScaffale)
                                            .frame(width: 175, height: 25)
                                            .font(.system(size: 17))
                                            .keyboardType(.numberPad)
                                            .padding(.leading, 10)
                                        
                                        Divider()
                                            .frame(width: 185, height: 0.5)
                                            .background(Color("ColoreDividerContrasto"))
                                            .padding(.leading, 10)

                                        
                                        TextField("Ripiano", text: $textFieldRipiano)
                                            .frame(width: 175, height: 25)
                                            .font(.system(size: 17))
                                            .keyboardType(.numberPad)
                                            .padding(.leading, 10)
                                            .padding(.bottom, 10)
                                    }
                                    .background(Color("ColoreContrasto"))
                                    .cornerRadius(13)
                                    .shadow(color: Color("ColoreContrasto"),radius: 22)
                                    
                                }
                                .padding(.leading, 40)
                                .animation(.easeInOut(duration: 0.1), value: showAggiuntaCopia) // Imposta una durata più breve per l'animazione
                                .transition(.move(edge: .trailing))
                            }
                        }
                        
                        
                        Divider()
                            .background(Color("ColoreDividerContrasto"))
                            .padding(.vertical, 20)
                            .padding(.leading, 17)
                        
                        if httpManager.libro?.idCategorie != ""{
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(items.indices, id: \.self) { index in
                                        items[index]
                                    }
                                }
                                .frame(height: 30)
                            }
                            .frame(height: 30)
                            .padding(.trailing, 20)
                            .padding(.leading, 10)
                        }
                        
                        NavigationView{
                            List {
                                ForEach(arrayLibri.indices, id: \.self) { index in
                                    
                                    //Se è l'ultimo item lo mette a "true", altrimente a "false"
                                    if index == ((httpManager.libro?.copie!.count)!) - 1{
                                        ItemGestioneCopiaLibro(datiLibro: CopiaLibro(
                                            idCopia: arrayLibri[index].idCopia,
                                            isbn: arrayLibri[index].isbn,
                                            condizioni: arrayLibri[index].condizioni,
                                            sezione: arrayLibri[index].sezione,
                                            scaffale: arrayLibri[index].scaffale,
                                            ripiano: arrayLibri[index].ripiano,
                                            idPrestito: arrayLibri[index].idPrestito),
                                                               data: httpManager,
                                                               index: $index,
                                                               datiLibroBinding: $datiLibro,
                                                               ricaricaPaginaBinding: $ricaricaGrafica)
                                        
                                    }else{
                                        ItemGestioneCopiaLibro(datiLibro: CopiaLibro(idCopia: arrayLibri[index].idCopia , isbn: arrayLibri[index].isbn, condizioni: arrayLibri[index].condizioni , sezione: arrayLibri[index].sezione, scaffale: arrayLibri[index].scaffale , ripiano: arrayLibri[index].ripiano, idPrestito: arrayLibri[index].idPrestito ), data: httpManager, index: $index, datiLibroBinding: $datiLibro, ricaricaPaginaBinding: $ricaricaGrafica)
                                    }
                                }
                                .onDelete(perform: { indexSet in
                                    
                                    httpManager.deleteCopia(idCopiaDelete: String(arrayLibri[indexSet.first!].idCopia))
                                
                                    self.ricaricaGrafica.toggle()
                                })
                            }
                            .listStyle(.plain)
                            .onChange(of: ricaricaGrafica, perform: { newValue in
                                httpManager.getCopieLibroDatoIsbn(isbn: datiLibro.isbn)
                            })
                            .refreshable {
                                httpManager.getCopieLibroDatoIsbn(isbn: datiLibro.isbn)
                            }
                            .navigationBarItems(leading:
                                                    HStack{
                                Text("Copie")
                                    .font(.largeTitle)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                
                                Button(action: {
                                    if showAggiuntaCopia && pickerCondizioni.rawValue != "" && textFieldSezione != ""{
                                        httpManager.postCopiaLibro(copiaDelLibro: CopiaLibro(idCopia: 0, isbn: datiLibro.isbn, condizioni: pickerCondizioni.rawValue, sezione: textFieldSezione != "" ? textFieldSezione : nil, scaffale: Int32(textFieldScaffale) ?? 0, ripiano: Int32(textFieldRipiano) ?? 0, idPrestito: -1))
                                        
                                        pickerCondizioni = .eccellenti
                                        textFieldSezione = ""
                                        textFieldScaffale = ""
                                        textFieldRipiano = ""
                                                                                
                                    }
                                    withAnimation(.easeIn(duration: 0.25)) {
                                        showAggiuntaCopia.toggle()
                                    }
                                    
                                    self.ricaricaGrafica.toggle()
                                    
                                }){
                                    ZStack{
                                        withAnimation(.easeIn(duration: 0.25)) {
                                            if !showAggiuntaCopia{
                                                Text("+")
                                                    .font(.title)
                                                    .foregroundColor(.primary)
                                                
                                            }else if pickerCondizioni.rawValue != "" && textFieldSezione != ""{
                                                Text("Avanti")
                                                    .font(.headline)
                                                    .foregroundColor(.accentColor)
                                                    //.shadow(color: Color.green, radius: 5)
                                                
                                            }else{
                                                Text("-")
                                                    .font(.title)
                                                    .foregroundColor(.primary)
                                            }
                                        }
                                        
                                    }
                                    //.frame(width: 25, height: 25)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.trailing, 10)

                            }
                                .frame(width: UIScreen.main.bounds.width)
                            )
                        }
                        .padding(.top, 5)
                    }
                }
                .onAppear(perform: {
                    httpManager.getCopieLibroDatoIsbn(isbn: datiLibro.isbn)
                    httpManager.getCategorieDelLibro(listaIdCategoria: datiLibro.idCategorie.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""))
                })
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
        
    var data: HttpManager
        
    var index: Binding<Int>
    var datiLibroBinding: Binding<DatiLibro>
    
    var ricaricaPaginaBinding: Binding<Bool>
    
    init(datiLibro: CopiaLibro, data: HttpManager, index: Binding<Int>, datiLibroBinding: Binding<DatiLibro>, ricaricaPaginaBinding: Binding<Bool>) {
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
                    .font(.headline)
                    .padding(.top)
                
                
                Text(datiLibroBinding.wrappedValue.autore)
                    .font(.footnote)
                
                Text("L'ID della copia è: " + String(copiaDelLibro.idCopia))
                    .font(.caption)
            }
            .padding(.trailing, 10)
        }
    }
}

struct MenuGestioneLibro_Previews: PreviewProvider {
    static var previews: some View {
        MenuGestioneLibro(datiLibro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil))
    }
}
