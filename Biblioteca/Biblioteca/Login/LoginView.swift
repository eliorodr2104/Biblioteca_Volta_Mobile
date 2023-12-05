//
//  LoginView.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 19/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import sharedModuleBiblioteca


struct LoginView: View {
    @State private var isAnimating = false
    
    @State private var animazionePulsante = false
    
    @StateObject var vm = SignIn_withGoogle_VM()
    
    @State var index = 0
    
    @State var nomeUtente = ""
    @State var email = ""
    @State var imgUtente = ""
                        
    var body: some View {
        if index == 1{
            let infoUtenteSplit = nomeUtente.split(separator: " ")
            
            RegistrazioneUtenteView(nomeUtente: String(infoUtenteSplit[0]),
                                    cognomeUtente: String(infoUtenteSplit[infoUtenteSplit.count > 2 ? 2 : 1]),
                                    mailVolta: email,
                                    imgUtente: imgUtente)
            
        }else{
            ZStack{
                
                Circle()
                    .fill(Color("ColorePrincipale"))
                    .frame(width: 250, height: 250)
                    .position(x: 0, y: 70)
                    
                
                Circle()
                    .fill(.purple)
                    .frame(width: 250, height: 250)
                    .position(x: 80, y: -40)
                    .opacity(0.95)
                    
                
                Circle()
                    .fill(Color("ColorePrincipale"))
                    .frame(width: 250, height: 250)
                    .position(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height - 70)
                    
                
                Button(action: {
                    // Aggiungi l'azione da eseguire quando il pulsante viene schiacciato
                    if !vm.isLoginSuccessed {
                        
                        vm.singInWithGoogle(index: $index, nomeUtente:  $nomeUtente, emailUtente: $email, imgUtente: $imgUtente)
                    }
                                    
                }) {
                    VStack(alignment: .center) {
                        Text("Biblioteca Volta")
                            .font(.largeTitle)
                            .bold()
                            .frame(height: UIScreen.main.bounds.width)
                            .padding(.top, 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.7)]), // Due tonalità di viola
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .mask(
                                        Text("Biblioteca Volta")
                                            .font(.largeTitle)
                                            .bold()
                                            .frame(height: UIScreen.main.bounds.width)
                                            .padding(.top, 30)
                                            .foregroundColor(.white) // Utilizza lo stesso colore del testo per il mascheramento
                                            .modifier(ColorAnimation(isAnimating: isAnimating)) // Applica l'animazione al colore
                                    )
                            )
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .scaleEffect(animazionePulsante ? 1.1 : 1.0) // Scala il testo del pulsante
                    //.animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) // Applica l'animazione di pulsazione
                    
                    //.animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animazionePulsante)
                    .onAppear{
                        withAnimation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true)) {
                            animazionePulsante.toggle()
                        }
                    }
                }
                .padding(.bottom, 15)
            }
            .background(ParticleView())
            
            
        }
    }
}

struct RegistrazioneUtenteView: View {
    
    private var mailVolta: String
    private var imgUtente: String
    
    @ObservedObject private var httpManager: HttpManager
    
    @State private var numeroTelefonoTextField = ""
    @State private var mailAlternativaTextField = ""
    
    @State private var nomeTextField = ""
    @State private var cognomeTextField = ""
    
    @State private var isEmptyNome = false
    @State private var isEmptyCognome = false
    @State private var isEmptyMailAlternativa = false
    
    @State private var alertFrame = false
    @State private var isRegistred = false
    
    init(nomeUtente: String, cognomeUtente: String, mailVolta: String, numeroTelefonoTextField: String = "", mailAlternativaTextField: String = "", imgUtente: String) {
        
        self.nomeTextField = nomeUtente
        self.cognomeTextField = cognomeUtente
        self.mailVolta = mailVolta
        self.imgUtente = imgUtente
                
        self.numeroTelefonoTextField = numeroTelefonoTextField
        self.mailAlternativaTextField = mailAlternativaTextField
        
        self.httpManager = HttpManager()
        
    }
    
    var body: some View {
        /*
        if getData.utente.nome == "LOADING"{
            
        }
         */
        //DEV'ESSERE DIVERSO DA ""
        if httpManager.utente.nome != "" || isRegistred{
            
            GeometryReader { geometry in
                
                /*
                 * Struttura condizionale che controlla se lo schermo ha lunghezza minore a 700,
                 * s'è vero apre il menù per telefono, altrimenti apre la visuale per il tablet.
                 */
                if geometry.size.width < 700 {
                    MenuSplit(nomeUtente: nomeTextField, salutoUtente: "Ciao", utenteUtilizzo: httpManager.utente,
                              datiLibro:
                                MenuLibro(datiLibro:
                                            DatiLibro(isbn: "",
                                                      titolo: "",
                                                      sottotitolo: nil,
                                                      lingua: "",
                                                      casaEditrice: nil,
                                                      autore: "",
                                                      annoPubblicazione: nil,
                                                      idCategorie: "",
                                                      idGenere: 0,
                                                      descrizione: nil,
                                                      np: 0,
                                                      image: nil),
                                                   index: .constant(0),
                                                   showAnimationSecondary: .constant(false),
                                                   show: .constant(false)),
                              imgUtente: imgUtente)
                    
                }else{
                    MenuSplitTablet(viewModel: MenuSplitTablet.ViewModel(), nomeUtente: "Eliomar", salutoUtente: "Ciao")
                }
            }
            
        }else{
            /*
             idUtente = SERVER
             nome = mail SERVER
             cognome = SETTA DALLA MAIL *OBBLIGATORIO*
             numero = INSERIMENTO UTENTE *NULL-SAFETY*
             mailAlter = INSERIMENTO UTENTE *OBBLIGATORIO*
             grado = set SERVER
             mailVolta = INSERIMENTO GOOGLE *OBBLIGATORIO*
             preferiti = nil Default *OBBLIGATORIO*
             */
            
            NavigationView {
                Form{
                    Section(header: Text("Informazioni:")) {
                        
                        LabelTextField(labelName: "Nome utente:", textFieldText: "Inserisci il tuo nome", textState: $nomeTextField)
                        
                        LabelTextField(labelName: "Cognome utente:", textFieldText: "Inserisci il tuo cognome", textState: $cognomeTextField)
                        
                        LabelTextField(labelName: "Mail secondaria:", textFieldText: "Inserisci la mail secondaria", textState: $mailAlternativaTextField)
                        
                        LabelTextField(labelName: "Numero di telefono:", textFieldText: "Inserisci il numero di telefono", textState: $numeroTelefonoTextField)
                            .keyboardType(.numberPad)
                        
                        VStack(alignment: .leading) {
                            Text("La tua mail istituzionale:")
                                .font(.headline)
                            Text(mailVolta)
                                .font(.subheadline)
                        }
                        
                    }
                }
                .navigationTitle("Registrazione")
                .accentColor(.primary)
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button{
                            hideKeyboard()
                            
                        }label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .foregroundColor(Color("ColorePrincipale"))
                        }
                        .padding(.trailing, -10)
                        
                        Button("Avanti") {
                            isEmptyNome = nomeTextField == "" ? true : false
                            
                            isEmptyCognome = cognomeTextField == "" ? true : false
                            
                            isEmptyMailAlternativa = mailAlternativaTextField == "" ? true : false
                            
                            if isEmptyNome || isEmptyCognome || isEmptyMailAlternativa {
                                alertFrame = true
                                
                            }else{
                                httpManager.postUtente(utente: Utente(idUtente: 0,
                                                                  nome: nomeTextField,
                                                                  cognome: cognomeTextField,
                                                                  numero: numeroTelefonoTextField == "" ? nil : numeroTelefonoTextField,
                                                                  mailAlternativa: mailAlternativaTextField,
                                                                  grado: 0,
                                                                  mail: mailVolta,
                                                                  preferiti: nil))
                                
                                httpManager.getUtenteDaEmail(email: mailVolta)
                                
                                isRegistred = true
                            }
                        }
                        .foregroundColor(Color("ColorePrincipale"))
                        .font(.title2)
                        .alert(isPresented: $alertFrame) {
                                    Alert(title: Text("Attenzione, campi mancanti")
                                        .font(.title2)
                                        .bold(),
                                        message: Text(isEmptyNome ? "Devi mettere il tuo nome!" :
                                                            isEmptyCognome ? "Devi mettere il tuo cognome!" :
                                                            isEmptyMailAlternativa ? "Devi mettere una email secondaria!" : "")
                                            .bold(),
                                          
                                        dismissButton: .default(Text("Continua")) {
                                        
                                            alertFrame = false
                                    })
                                }
                        
                    }
                }
                
            }
            .onAppear(perform: {
                httpManager.getUtenteDaEmail(email: mailVolta)
            })
            .padding(.top, 20)
        }
    }
}

struct ColorAnimation: AnimatableModifier {
    var animatableData: Double

    init(isAnimating: Bool) {
        animatableData = isAnimating ? 0 : 1
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width / 5, height: geometry.size.height)
                            .offset(x: -geometry.size.width + (geometry.size.width / 5 * CGFloat(index)) + CGFloat(animatableData) * geometry.size.width)
                            .opacity(1 - animatableData)
                    }
                }
            )
    }
}

#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
