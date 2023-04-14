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

@main
struct iOSApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
        }
	}
}
