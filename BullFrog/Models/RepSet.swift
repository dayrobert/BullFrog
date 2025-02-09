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
    var workout: Workout?
    var number: Int
    var reps: Int
    var weight: Int
    
    init(number: Int, reps: Int = 0, weight: Int = 0) {
        self.number = number
        self.reps = reps
        self.weight = weight
    }

    init( workout: Workout, number: Int, reps: Int = 0, weight: Int = 0) {
        self.workout = workout
        self.number = number
        self.reps = reps
        self.weight = weight
    }
    
    static let sampleData = [
        RepSet( number: 1, reps: 10, weight: 100 ),
        RepSet( number: 2, reps: 10, weight: 100 ),
        RepSet( number: 3, reps: 8, weight: 100 ),
    ]
}

