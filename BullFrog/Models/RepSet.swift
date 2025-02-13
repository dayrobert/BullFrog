//
//  Untitled.swift
//  BullFrog
//
//  Created by Robert Day on 12/20/24.
//

import Foundation
import SwiftData

@Model
final class RepSet {
    @Attribute(.unique) var id: UUID = UUID()
    var index: Int? = nil
    var reps: Int? = nil
    var weight: Int? = nil

    @Relationship(deleteRule: .cascade) var workout: Workout? = nil

    private init(number: Int, reps: Int? = nil, weight: Int? = nil) {
        self.index = number
        self.reps = reps
        self.weight = weight
    }

    init( workout: Workout, number: Int, reps: Int? = nil, weight: Int? = nil) {
        self.workout = workout
        self.index = number
        self.reps = reps
        self.weight = weight
    }
    
    static let sampleData = [
        RepSet( number: 1, reps: 10, weight: 100 ),
        RepSet( number: 2, reps: 10, weight: 100 ),
        RepSet( number: 3, reps: 8, weight: 100 ),
    ]
}

