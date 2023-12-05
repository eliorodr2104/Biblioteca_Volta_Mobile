/**
 * Created by eliomar rodriguez on 27/03/23.
 *
 * Descrizione: viene utilizzata la GeometryReader per controllare la larghezza dello schermo del dispositivo in cui viene eseguita l'app.
 * Se la larghezza è inferiore a 700 punti, viene visualizzata la vista MenuSplit, altrimenti viene visualizzata la vista MenuSplitTablet.
 * Questo consente di creare una versione dell'app con una diversa interfaccia utente a seconda delle dimensioni dello schermo.
 *
 * La vista MenuSplit o MenuSplitTablet potrebbero essere altre viste personalizzate dell'applicazione, che mostrano il menu principale
 * dell'applicazione.
 *
 * Progetto: Biblioteca
 * SwiftUI view Login.swift
 *
 * Copyright © 2023 4AI.  All rights reserved.
 */
import SwiftUI
import sharedModuleBiblioteca

@available(iOS 15.0, *)
struct ContentView: View {
    
	var body: some View {
        LoginView()
	}
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
