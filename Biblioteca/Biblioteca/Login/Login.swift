//
//  Login.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 27/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct Login: View {
    @State private var textEmail: String = ""
    @State private var textPassword: String = ""
    
    @State var statoMenu = false
    @State var erroreMail = false
    @State var errorePassword = false
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        if statoMenu {
            if screenWidth < 700 {
                MenuSplit(nomeUtente: "Eliomar", salutoUtente: "Ciao")
            } else {
                MenuSplitTablet(nomeUtente: "Eliomar", salutoUtente: "Ciao")
            }
            
        }else{
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

private func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@volta-alessandria\\.it"
    
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    
    return emailPredicate.evaluate(with: email)
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
