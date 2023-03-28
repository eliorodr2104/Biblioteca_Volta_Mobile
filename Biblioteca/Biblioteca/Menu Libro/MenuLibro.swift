//
//  MenuLibro.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 23/03/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MenuLibro: View {
    var titolo: String
    var autore: String
    var numeroCopie: Int
    var disponibilitaLibro: Bool
    
    @State var controlloDimensione = false
        
    var body: some View {
        GeometryReader { geometry in
            let isLargeSize = geometry.size.width >= 700
            
            ZStack {
                // il resto del codice
                
                VStack(alignment: .leading){
                    HStack(alignment: .top){
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(color: Color("ColoreCard"), radius: 6)
                            
                            Image("")
                            
                        }
                        .frame(width: 113, height: 175)
                        .padding(.horizontal, 10)
                        
                        Spacer(minLength: 5)
                        
                        VStack(alignment: .leading) {
                            Text(titolo)
                                .font(isLargeSize ? .largeTitle : .title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text(autore)
                                .fontWeight(.bold)
                                .font(isLargeSize ? .headline : .subheadline)
                                .foregroundColor(.primary.opacity(0.5))
                            
                            if disponibilitaLibro {
                                Text("Disponibile")
                                    .fontWeight(.bold)
                                    .font(isLargeSize ? .body : .subheadline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 5)
                                
                                Text("Il numero di copie di copie è: " + String(numeroCopie))
                                    .fontWeight(.bold)
                                    .font(isLargeSize ? .headline : .subheadline)
                                    .foregroundColor(.primary.opacity(0.5))
                                    .padding(.bottom, 5)
                            } else {
                                Text("Non disponibile al prestito")
                                    .fontWeight(.bold)
                                    .font(isLargeSize ? .body : .subheadline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.horizontal, isLargeSize ? 20 : 10)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

struct MenuLibro_Previews: PreviewProvider {
    static var previews: some View {
        MenuLibro(titolo: "", autore: "", numeroCopie: 0 ,disponibilitaLibro: true)
    }
}
