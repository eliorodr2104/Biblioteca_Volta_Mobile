/**
 * Created by eliomar rodriguez on 27/03/23.
 *
 * Descrizione: l codice importa il framework SwiftUI e definisce una struttura di vista denominata Login. La vista è composta da una struttura
 * condizionale che definisce se deve visualizzare il menu o il form di login. All'interno del form di login, l'utente può inserire la propria email e
 * password. Ci sono anche due stati per la gestione degli errori email e degli errori password.
 * La validità della email e della password viene controllata alla pressione del pulsante "Avanti".
 * Se le credenziali sono valide, lo stato del menu viene impostato su "vero". In caso contrario, gli stati degli errori vengono impostati su "vero".
 * Il codice è ben strutturato e commentato, con una descrizione dettagliata di ogni variabile e funzione.
 *
 * Progetto: Biblioteca
 * SwiftUI view Login.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

/**
 * Created by eliomar rodriguez on 27/03/23.
 *
 * Descrizione: Struttura che definisce la vista di Login.
 */
@available(iOS 15.0, *)
struct Login: View {
    //Stati privati per la gestione dell'input email e password.
    @State private var textEmail: String = ""
    @State private var textPassword: String = ""
    
    //Stati per la gestione del menu, degli errori email e degli errori password.
    @State var statoMenu = false
    @State var erroreMail = false
    @State var errorePassword = false
    
    //Dimensione della larghezza dello schermo.
    let screenWidth = UIScreen.main.bounds.width
    
    //Corpo della vista, composto da una struttura condizionale e uno ZStack.
    var body: some View {
        
        //Struttura condizionale per la visualizzazione del menu o del form di Login.
        if statoMenu {
            
            /*
             * Struttura condizionale che controlla se lo schermo ha lunghezza minore a 700,
             * s'è vero apre il menù per telefono, altrimenti apre la visuale per il tablet.
             */
            if screenWidth < 700 {
                MenuSplit(nomeUtente: "Eliomar", utenteUtilizzo: Utente(idUtente: 0, nome: "", cognome: "", numero: nil, mailAlternativa: "", grado: 0, mail: "", preferiti: nil), datiLibro: MenuLibro(datiLibro: DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil), index: .constant(0), showAnimationSecondary: .constant(false), show: .constant(false)))
                
            } else {
                MenuSplitTablet(viewModel: MenuSplitTablet.ViewModel(), nomeUtente: "Eliomar", salutoUtente: "Ciao")
            }
            
        }else{
            
            /*
             * La vista contiene una serie di elementi grafici, tra cui una forma arrotondata colorata, un
             * titolo di benvenuto, due campi di testo (uno per l'email e uno per la password), due
             * pulsanti e alcune logiche di validazione per la gestione degli errori di inserimento dei
             * dati.
             * In particolare, i campi di testo utilizzano la sintassi di binding di SwiftUI per mantenere
             * sincronizzati i valori inseriti dall'utente con le variabili di stato della vista. La
             * logica di validazione viene gestita nell'action del pulsante "Avanti" tramite una struttura
             * condizionale che verifica se l'email inserita è valida e se la password non è vuota.
             *
             * Se una delle due condizioni non viene soddisfatta, la vista mostra un messaggio di errore
             * sotto il campo di testo corrispondente. Altrimenti, la variabile di stato "statoMenu" viene
             * impostata su "true" per indicare che l'utente ha effettuato l'accesso con successo e può
             * procedere alla visualizzazione della schermata successiva.
             *
             * Infine, la vista utilizza una serie di tecniche di posizionamento e layout per garantire
             * che gli elementi grafici siano visualizzati correttamente su schermi di diverse dimensioni.
             *
             */
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("ColoreLogin"))
                    .shadow(color: .primary, radius: 3)
                
                VStack(alignment: .leading){
                    Text("Benvenuto")
                        .foregroundColor(Color.primary)
                        .font(.system(size: 35, weight: .bold))
                        .padding(.top, 100)
                        .padding(.leading, 5)
                    
                    Text("Inserisci le credenziali per andare avanti.")
                        .foregroundColor(Color.secondary)
                        .font(.system(size: 14))
                        .padding(.leading, 5)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    HStack{
                        Image("")
                            .overlay(Rectangle()
                                .stroke(Color.secondary.opacity(5), lineWidth: 2)
                                .frame(width: 30, height: 30)
                            )
                            .padding(.leading, 20)
                            .padding(.trailing, 7)
                            .padding(.top, 15)
                        
                        TextField("Email", text: $textEmail)
                            .padding(.top, 35)
                            .padding(.leading, 5)
                            .padding(.trailing, 20)
                            .padding(.bottom, 17)
                            .overlay(Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.secondary.opacity(5))
                                    .padding(.leading, 5)
                                    .padding(.trailing, 20)
                                    .padding(.bottom, erroreMail ? 0 : 15),
                                     alignment: .bottom)
                            .font(.headline)
                    }
                    
                    //Struttura condizionale per la visualizzazione dell'errore email.
                    if erroreMail{
                        Text("Mail sbagliata")
                            .foregroundColor(Color.secondary)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .padding(.leading, 5)
                            .font(.system(size: 14))
                    }
                    
                    HStack{
                        Image("")
                            .overlay(Rectangle()
                                .stroke(Color.secondary.opacity(5), lineWidth: 2)
                                .frame(width: 30, height: 30)
                            )
                            .padding(.leading, 20)
                            .padding(.trailing, 7)
                            .padding(.top, 1)
                        
                        SecureField("Password", text: $textPassword)
                            .padding(.bottom, 17)
                            .padding(.leading, 5)
                            .padding(.trailing, 20)
                            .padding(.top, 20)
                            .overlay(Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.secondary.opacity(5))
                                    .padding(.leading, 5)
                                    .padding(.trailing, 20)
                                    .padding(.bottom, erroreMail ? 0 : 15),
                                     alignment: .bottom)
                            .font(.headline)
                    }
                      
                    //Struttura condizionale per la visualizzazione dell'errore password.
                    if errorePassword{
                        Text("Password vuota")
                            .foregroundColor(Color.secondary)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .padding(.leading, 5)
                            .font(.system(size: 14))
                    }
                    
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            
                            /*
                             * Struttura condizionale dentro
                             * l'action di un button per la gestione dei errori per la email
                             * e per la password.
                             */
                            if isValidEmail(email: textEmail) && !textPassword.isEmpty{
                                statoMenu = true
                                
                            }else{
                                if !isValidEmail(email: textEmail){
                                    erroreMail = true
                                    
                                }else{
                                    erroreMail = false
                                }
                                
                                if textPassword .isEmpty{
                                    errorePassword = true
                                    
                                }else{
                                    errorePassword = false
                                }
                            }
                            
                        }){
                            Text("Avanti")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .background(Color("ColorePrincipale").opacity(0.7))
                        .foregroundColor(Color.white)
                        .cornerRadius(9)
                        .padding(.trailing, 5)
                    }
                    .padding(.bottom, 10)
                    
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            
                        }){
                            Text("Google")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .background(Color("ColorePrincipale").opacity(0.7))
                        .foregroundColor(Color.white)
                        .cornerRadius(9)
                        .padding(.trailing, 5)
                    }
                    .padding(.bottom, 10)
                    
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 1.5)
        }
    }
}

/**
 * Created by eliomar rodriguez on 27/03/23.
 *
 * Descrizione: La funzione isValidEmail accetta una stringa come parametro, che rappresenta l'indirizzo email che deve essere validato.
 * La funzione utilizza una espressione regolare per definire un pattern per l'indirizzo email accettabile.
 *
 * In particolare, l'espressione regolare "[A-Z0-9a-z._%+-]+@volta-alessandria\\.it" corrisponde a una stringa composta da una o più lettere
 * maiuscole o minuscole, cifre o simboli di punteggiatura (come il punto o il trattino), seguiti dal carattere '@' e dalla stringa "volta-alessandria.it".
 *
 * La funzione utilizza quindi l'oggetto NSPredicate per valutare se la stringa dell'indirizzo email corrisponde al pattern definito dall'espressione
 * regolare. Se la stringa è valida, la funzione restituisce true, altrimenti restituisce false.
 *
 * Progetto: Biblioteca
 * SwiftUI view Login.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
private func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@volta-alessandria\\.it"
    
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    
    return emailPredicate.evaluate(with: email)
}


@available(iOS 15.0, *)
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
