//
//  Application.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 19/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import UIKit

final class Application_utility{
    static var rootViewController: UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
