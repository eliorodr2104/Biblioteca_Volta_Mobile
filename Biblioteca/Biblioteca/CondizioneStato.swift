//
//  CondizioneStato.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 27/09/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

enum CondizioneStato: String, CaseIterable, Identifiable {
    case eccellenti
    case ottime
    case buone
    case mediocre
    case scadenti
    var id: Self { self }
}


extension CondizioneStato {
    var descrizione: CondizioneStato {
        switch self {
        case .eccellenti: return .eccellenti
        case .ottime: return .ottime
        case .buone: return .buone
        case .mediocre: return .mediocre
        case .scadenti: return .scadenti
        }
    }
}
