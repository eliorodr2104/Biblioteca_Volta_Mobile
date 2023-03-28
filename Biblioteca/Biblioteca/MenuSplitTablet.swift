//
//  MenuSplitTablet.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 23/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MenuSplitTablet: View {
    private let CONST_INDEX_LIBRI = 5
    
    @State var index = 0
    
    @State var showAnimationSecondary = false
    
    @State var datiLibro = MenuLibro(titolo: "", autore: "", numeroCopie: 0, disponibilitaLibro: false)

    var nomeUtente: String
    var salutoUtente: String
    
    
    var body: some View {
        ZStack{
            //Menu Utente
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    
                    //Immagine Profilo
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
                    
                    //Pulsante visualizzazione catalogo
                    Button(action: {
                        self.index = 0
                        //Indice di riconoscimento azione
                        
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
                    
                    //Pulsante visualizzazione libri prestito
                    Button(action: {
                        self.index = 1
                        //Indice di riconoscimento azione
                        
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
                    
                    //Pulsante visualizzazione informazioni
                    Button(action: {
                        self.index = 2
                        //Indice di riconoscimento azione
                        
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
                    
                    //Pulsante visualizzazione notifiche app
                    Button(action: {
                        self.index = 3
                        //Indice di riconoscimento azione
                        
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
                    
                    //Pulsante visualizzazione impostazioni
                    Button(action: {
                        self.index = 4
                        //Indice di riconoscimento azione
                        
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
            
            //Schermata principale
            VStack(spacing: 0){
                
                HStack(spacing: 15){
                    
                    //Pulsante per la chiusura del menu
                    Button(action: {
                        if self.showAnimationSecondary{
                            self.index = 0
                            
                            withAnimation{ self.showAnimationSecondary.toggle() }
                            
                        }
                        
                    }) {
                        if self.showAnimationSecondary{
                            Image(systemName: self.showAnimationSecondary ? "chevron.left" : "")
                                .resizable()
                                .frame(width: self.showAnimationSecondary ? 18 : 22, height: 18)
                                .foregroundColor(Color.primary.opacity(0.4))
                        }
                        
                    }
                    
                    //Cambia il testo del pulsante dipendendo dall'indice scelto
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
                
                GeometryReader{_ in
                    
                    VStack{
                        
                        let prova = [
                            ItemOrizzontaliLista(
                                cardPrimi: CardLibri(
                                    titolo: "ciao",
                                    descrizione: "ciao"),
                                
                                cardSecondo: CardLibri(
                                    titolo: "ciao1",
                                    descrizione: "ciaooo1"),
                                
                                funzionePrimaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao", autore: "ciao", numeroCopie: 10 ,disponibilitaLibro: true)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                },
                                
                                funzioneSecondaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao1", autore: "ciaooo1", numeroCopie: 5, disponibilitaLibro: true)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                }
                                
                            ),
                            ItemOrizzontaliLista(
                                cardPrimi: CardLibri(
                                    titolo: "ciao2",
                                    descrizione: "ciao2"),
                                
                                cardSecondo: CardLibri(
                                    titolo: "ciao3",
                                    descrizione: "ciaooo3"),
                                
                                funzionePrimaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao2", autore: "ciao2", numeroCopie: 0, disponibilitaLibro: false)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                },
                                
                                funzioneSecondaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao3", autore: "ciaooo3", numeroCopie: 2, disponibilitaLibro: true)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                }
                                
                            ),
                            ItemOrizzontaliLista(
                                cardPrimi: CardLibri(
                                    titolo: "ciao4",
                                    descrizione: "ciao4"),
                                
                                cardSecondo: CardLibri(
                                    titolo: "ciao5",
                                    descrizione: "ciaooo5"),
                                
                                funzionePrimaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao4", autore: "ciao4", numeroCopie: 0, disponibilitaLibro: false)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                },
                                
                                funzioneSecondaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao5", autore: "ciaooo5", numeroCopie: 0, disponibilitaLibro: false)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                }
                            ),
                            ItemOrizzontaliLista(
                                cardPrimi: CardLibri(
                                    titolo: "ciao6",
                                    descrizione: "ciao6"),
                                
                                cardSecondo: CardLibri(
                                    titolo: "ciao7",
                                    descrizione: "ciaooo7"),
                                
                                funzionePrimaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao6", autore: "ciao6", numeroCopie: 0, disponibilitaLibro: false)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                },
                                
                                funzioneSecondaCard: {
                                    self.index = CONST_INDEX_LIBRI
                                    
                                    self.datiLibro = MenuLibro(titolo: "ciao7", autore: "ciaooo7", numeroCopie: 0, disponibilitaLibro: false)
                                    
                                    withAnimation{ self.showAnimationSecondary.toggle() }
                                }
                            )
                        ]
                        
                        //Cambia la visuale dipendendo dall'indice
                        if self.index == 0{
                            ListaVisualizzazione(listaItemOrizzontale: prova)
                            
                        } else if self.index == 1{
                            
                            
                        } else if self.index == 2{
                            
                            
                        } else if self.index == 3{
                            
                        }else if self.index == 4{
                            
                        }else{
                            MenuLibro(titolo: datiLibro.titolo, autore: datiLibro.autore, numeroCopie: datiLibro.numeroCopie ,disponibilitaLibro: datiLibro.disponibilitaLibro)
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

struct MenuSplitTablet_Previews: PreviewProvider {
    static var previews: some View {
        MenuSplitTablet(nomeUtente: "", salutoUtente: "")
    }
}
