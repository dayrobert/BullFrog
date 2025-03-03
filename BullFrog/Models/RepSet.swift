//
//  Untitled.swift
//  BullFrog
//
//  Created by Robert Day on 12/20/24.
//

import Foundation
import SwiftData

@Model
final class RepSet: Identifiable {
    @Relationship(deleteRule: .cascade) var workout: Workout? = nil

    var index: Int
    var reps: Int
    var weight: Int

    private init(index: Int, reps: Int, weight: Int) {
        self.index = index
        self.reps = reps
        self.weight = weight
    }

    init( workout: Workout, index: Int, reps: Int, weight: Int) {
        self.workout = workout
        self.index = index
        self.reps = reps
        self.weight = weight
    }
    
    static let sampleData = [
        RepSet( index: 1, reps: 10, weight: 100 ),
        RepSet( index: 2, reps: 10, weight: 100 ),
        RepSet( index: 3, reps: 8, weight: 100 ),
    ]
}

