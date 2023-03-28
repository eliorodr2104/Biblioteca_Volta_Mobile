import SwiftUI

struct ContentView: View {
	var body: some View {
        Login()
        
        /*
        GeometryReader { geometry in
            if geometry.size.width < 700 {
                MenuSplit(nomeUtente: "Eliomar", salutoUtente: "Ciao")
                
            }else{
                MenuSplitTablet(nomeUtente: "Eliomar", salutoUtente: "Ciao")
            }
        }
         */
         
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
