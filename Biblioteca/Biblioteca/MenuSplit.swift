//
//  MenuSplit.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 22/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MenuSplit: View {
    
    @State var index = 0
    @State var show = false
    
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
                        
                        //Each Time Tab Is Clicked Menu Will be Closed...
                        withAnimation{ self.show.toggle() }
                        
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
                        
                        //Each Time Tab Is Clicked Menu Will be Closed...
                        withAnimation{ self.show.toggle() }
                        
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
                        
                        //Each Time Tab Is Clicked Menu Will be Closed...
                        withAnimation{ self.show.toggle() }
                        
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
                        
                        //Each Time Tab Is Clicked Menu Will be Closed...
                        withAnimation{ self.show.toggle() }
                        
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
                        
                        //Each Time Tab Is Clicked Menu Will be Closed...
                        withAnimation{ self.show.toggle() }
                        
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
                        withAnimation{ self.show.toggle() }
                        
                    }) {
                        Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                            .resizable()
                            .frame(width: self.show ? 18 : 22, height: 18)
                            .foregroundColor(Color.primary.opacity(0.4))
                    }
                                
                    //Cambia il testo del pulsante dipendendo dall'indice scelto
                    Text(self.index == 0 ? "Catalogo" :
                            (self.index == 1 ? "Libri Prestito" :
                                (self.index == 2 ? "Informazioni" :
                                    (self.index == 3 ? "Notifiche App" : "Impostazioni"))))
                        .font(.title)
                        .foregroundColor(Color.primary.opacity(0.6))
                    
                    Spacer(minLength: 0)
                    
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                            
                GeometryReader{_ in
                
                    VStack{
                        //Cambia la visuale dipendendo dall'indice
                        if self.index == 0{
                            ListaVisualizzazione()
                                .allowsHitTesting(self.show ? false : true)
                            
                        } else if self.index == 1{

                            
                        } else if self.index == 2{

                            
                        } else{
                            
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

struct MenuSplit_Previews: PreviewProvider {
    static var previews: some View {
        MenuSplit(nomeUtente: "", salutoUtente: "")
    }
}
