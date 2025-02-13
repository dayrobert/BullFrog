//
//  Item.swift
//  BullFrog
//
//  Created by Robert Day on 12/18/24.
//

import Foundation
import SwiftData

@Model
final class Session: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var timestamp: Date
    var facility: Facility? = nil
    
    @Relationship(deleteRule: .cascade, inverse: \Workout.session) var workouts = [Workout]()

    init(timestamp: Date, facility: Facility? = nil) {
        self.timestamp = timestamp
        self.facility = facility
    }
    
    static let sampleData = [
        Session( timestamp: .now ),
        Session( timestamp: .now.addingTimeInterval(TimeInterval(-1000))),
        Session( timestamp: .now.addingTimeInterval(TimeInterval(-4000)))
    ]
}

