//
//  Item.swift
//  BullFrog
//
//  Created by Robert Day on 12/18/24.
//

import Foundation
import SwiftData

@Model
final class Session {
    var timestamp: Date
    var facility: String?
    var workouts = [Workout]()

    init(timestamp: Date, facility: String? = nil) {
        self.timestamp = timestamp
        self.facility = facility
    }
    
    static let sampleData = [
        Session( timestamp: .now, facility: "The Gym" ),
        Session( timestamp: .now.addingTimeInterval(TimeInterval(-1000)), facility: "Home"),
        Session( timestamp: .now.addingTimeInterval(TimeInterval(-4000)), facility: "At Gym")
    ]
}

