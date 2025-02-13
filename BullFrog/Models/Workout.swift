//
//  WorkoutSet.swift
//  BullFrog
//
//  Created by Robert Day on 2/7/25.
//


import Foundation
import SwiftData

@Model
final class Workout: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()

    @Relationship(deleteRule: .cascade) var session: Session? = nil
    @Relationship(deleteRule: .nullify) var exercise: Exercise? = nil
    @Relationship(deleteRule: .cascade, inverse: \RepSet.workout) var repSets = [RepSet]()
    
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
