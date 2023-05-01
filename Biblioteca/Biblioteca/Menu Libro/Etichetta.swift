//
//  Etichetta.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 28/04/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct Etichetta: View {
    var nomeEtichetta: String
    
    var body: some View {
        HStack(alignment: .center){
            Text(nomeEtichetta)
                .font(.subheadline)
                .padding(.leading, 4)
                .padding(.trailing, 4)
        }
        .frame(width: 75, height: 30)
        .background(Color("ColoreEtichetta"))
        .cornerRadius(6)
    }
}

struct Etichetta_Previews: PreviewProvider {
    static var previews: some View {
        Etichetta(nomeEtichetta: "")
    }
}
