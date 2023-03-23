import SwiftUI
import sharedModuleBiblioteca

struct ContentView: View {
	let greet = Greeting().greet()

	var body: some View {
        
        MenuSplit(nomeUtente: "Eliomar", salutoUtente: "Ciao")
        
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
