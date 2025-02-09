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
    var session: Session?
    var name: String // Exercise
    var repSets = [RepSet]()
    
    init(name: String = "") {
        self.name = name
    }
    
    init( session: Session, name: String = "") {
        self.session = session
        self.name = name
    }
    
    static let sampleData = [
        Workout( name: "leg_press" ),
        Workout( name: "check_press" ),
        Workout( name: "back_row" ),
        Workout( name: "curl" )
    ]
}
