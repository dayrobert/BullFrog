//
//  Exercise.swift
//  BullFrog
//
//  Created by Robert Day on 12/20/24.
//

import Foundation
import SwiftData

@Model
final class Exercise {
    var name: String
    var category: ExerciseCategory?

    init(name: String?, category: ExerciseCategory?) {
        self.name = name ?? ""
        self.category = category
    }
    
    static let sampleData = [
        Exercise( name: "Bench Press", category: .strength_training  ),
        Exercise( name: "Lat Pull", category: .strength_training  ),
        Exercise( name: "Indoor Run", category: .cardio ),
        Exercise( name: "Stationary Bike", category: .cardio ),
    ]
}

enum ExerciseCategory: String, Codable, CaseIterable {
    case strength_training = "Strength Training"
    case cardio = "Cardio"
    
    var name: String { rawValue }
}
