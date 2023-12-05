//
//  SigninGoogle.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 19/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

import sharedModuleBiblioteca

class SignIn_withGoogle_VM: ObservableObject{
    
    @Published var isLoginSuccessed = false
    
    func singInWithGoogle(index: Binding<Int>, nomeUtente: Binding<String>, emailUtente: Binding<String>, imgUtente: Binding<String>){
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
                        
            if error != nil {
                return
            }
            
            guard
                let user = user?.user,
                let idToken = user.idToken else {return}
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                        
            Auth.auth().signIn(with: credential) { res, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = res?.user else {return}
                
                if ((user.email?.contains("@volta-alessandria.it")) != nil){
                    
                    withAnimation(Animation.easeIn ) {
                        self.isLoginSuccessed = true
                                        
                        nomeUtente.wrappedValue = user.displayName ?? ""
                        emailUtente.wrappedValue = user.email ?? ""
                        imgUtente.wrappedValue = user.photoURL?.absoluteString ?? ""
                        
                        index.wrappedValue = 1
                    }
                }
            }
        }
    }
}


struct SigninGoogle: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SigninGoogle_Previews: PreviewProvider {
    static var previews: some View {
        SigninGoogle()
    }
}
