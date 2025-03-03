//
//  Exercise.swift
//  BullFrog
//
//  Created by Robert Day on 12/20/24.
//

import Foundation
import SwiftData

@Model
final class Facility {
    var name: String

    init( name: String? = nil ) {
        self.name = name ?? ""
    }
    
    static let sampleData = [
        Facility( name: "Outdoors" ),
        Facility( name: "Planet Fitness" ),
        Facility( name: "Home" ),
    ]
}
