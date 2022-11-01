//
//  Thread.swift
//  APOD
//
//  Created by Juan Diego Marin on 31/10/22.
//

import Foundation

enum Thread {
    
    static func main(_ block: @escaping () -> Void?) {
        DispatchQueue.main.async {
            block()
        }
    }
}
