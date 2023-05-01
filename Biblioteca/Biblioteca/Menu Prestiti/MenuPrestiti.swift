//
//  MenuPrestiti.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 14/04/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import sharedModuleBiblioteca

struct MenuPrestiti: View {
    @State var listaItemPrestiti = [ItemPrestitiLista]()
    
    private let quantitaPrestiti: Int
        
    init(listaItemPrestiti: [ItemPrestitiLista] = [ItemPrestitiLista]()) {
        self.listaItemPrestiti = listaItemPrestiti
        self.quantitaPrestiti = listaItemPrestiti.count
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(listaItemPrestiti.indices, id: \.self) { index in
                    /*
                    switch calcolaGiorniRimanenti(listaItemPrestiti[index].libro.prestito.dataInizio ?? "00/00/0000") {
                    case 0...3:
                        listaItemPrestiti[index].foregroundColor(Color.red)
                        
                    case 4...5:
                        listaItemPrestiti[index].foregroundColor(Color.orange)
                        
                    default:
                        listaItemPrestiti[index].foregroundColor(Color.green)
                    }
                     */
                    
                    listaItemPrestiti[index]
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Libri in prestito: " + String(quantitaPrestiti))
        }
    }
}

func calcolaGiorniRimanenti(_ dateString: String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    if let date = dateFormatter.date(from: dateString) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: date)
                
        return components.day ?? 0
    }
    
    return 0
}


struct MenuPrestiti_Previews: PreviewProvider {
    static var previews: some View {
        MenuPrestiti()
    }
}
