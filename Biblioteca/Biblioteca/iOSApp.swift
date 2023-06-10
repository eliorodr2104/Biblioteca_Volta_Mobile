/**
 * Created by eliomar rodriguez on 20/03/23.
 *
 * Descrizione: La struttura iOSApp implementa il protocollo App di SwiftUI, che è responsabile della creazione e gestione dell'interfaccia utente dell'app.
 *
 * La funzione body è una dichiarazione obbligatoria per ogni tipo di App in SwiftUI, e definisce l'interfaccia utente principale dell'applicazione. In questo caso,
 * viene creato un'istanza di ContentView e mostrata come contenuto della finestra principale (WindowGroup) dell'app.
 *
 * Progetto: Biblioteca
 * SwiftUI view iOSApp.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import Firebase
import GoogleSignIn

@available(iOS 15.0, *)
@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	var body: some Scene {
		WindowGroup {
			ContentView()
        }
	}
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool{
        
        return GIDSignIn.sharedInstance.handle(url)
    }
}
