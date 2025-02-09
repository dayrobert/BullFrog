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
    var type: ExerciseType
    
    init(exerciseType: ExerciseType) {
        self.type = exerciseType
    }
}

enum ExerciseType: String, Codable, CaseIterable, Identifiable {
    case leg_press = "Leg Press"
    case chest_press = "Chest Press"
    case back_row = "Row"
    
    var id: String { return self.rawValue }

    var name: String {
      switch self {
      case .leg_press:   return "Leg Press"
      case .chest_press: return "Check Press"
      case .back_row:   return "Row"
      }
    }
}

