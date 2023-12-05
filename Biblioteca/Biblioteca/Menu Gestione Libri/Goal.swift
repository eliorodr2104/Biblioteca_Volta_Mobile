//
//  Goal.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 20/09/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

struct Goal: Hashable, Identifiable {
    var id: String { name }
    var name: String
    var identificableNumber: String
}
