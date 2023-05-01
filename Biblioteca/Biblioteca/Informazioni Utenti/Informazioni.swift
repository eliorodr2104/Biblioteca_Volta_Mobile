//
//  Informazioni.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 01/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct Informazioni: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
                HStack(alignment: .center){
                    ZStack{
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.white)
                        
                        Image(systemName: "xmark")
                            .cornerRadius(50)
                    }
                    .frame(width: 120, height: 120)

                }
                .padding(.leading, geometry.size.width/2)
                .padding(.trailing, geometry.size.width/2)
                
                Text("ciao")
                    .font(.title)
                Text("CIAO")
                    .font(.title)
            }
            .background(Color(UIColor.systemBackground))
            .frame(width: geometry.size.width)
        }
    }
}

struct Informazioni_Previews: PreviewProvider {
    static var previews: some View {
        Informazioni()
    }
}
