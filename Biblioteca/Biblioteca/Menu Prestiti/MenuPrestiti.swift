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
    @State var listaPrestiti = [Prestito]()
    
    private let quantitaPrestiti: Int
    private let itemListaPrestiti: [ItemPrestitiLista]
        
    init(listaPrestiti: [Prestito] = [Prestito]()) {
        self.listaPrestiti = listaPrestiti
        self.quantitaPrestiti = listaPrestiti.count
        self.itemListaPrestiti = convertiOggetti(listaPrestiti: listaPrestiti)
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(itemListaPrestiti.indices, id: \.self) { index in
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
                    
                    itemListaPrestiti[index]
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Libri in prestito: " + String(quantitaPrestiti))
        }
    }
}

func convertiOggetti(listaPrestiti: [Prestito]) -> [ItemPrestitiLista]{
    var itemListaPrestiti = [ItemPrestitiLista]()

    
    for prestitoSingolo in listaPrestiti{
        itemListaPrestiti.append(ItemPrestitiLista(prestitoLibro: prestitoSingolo))
    }
    
    return itemListaPrestiti
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
