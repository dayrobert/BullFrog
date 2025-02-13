//
//  WorkoutSet.swift
//  BullFrog
//
//  Created by Robert Day on 2/7/25.
//


import Foundation
import SwiftData

@Model
final class Workout {
    var session: Session? = nil
    var exercise: Exercise? = nil
    var repSets = [RepSet]()
    
    init( session: Session?, exercise: Exercise? ) {
        self.session = session
        self.exercise = exercise
    }
    
    static let sampleData = [
        Workout( session: nil, exercise: Exercise.sampleData[0] ),
        Workout( session: nil, exercise: Exercise.sampleData[1] ),
        Workout( session: nil, exercise: Exercise.sampleData[2] ),
        Workout( session: nil, exercise: Exercise.sampleData[3] )
    ]
}
