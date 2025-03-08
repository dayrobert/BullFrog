//
//  SampleData.swift
//  FriendsFavoriteMovie
//
//  Created by Robert Day on 1/2/25.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()

    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var session: Session {
        Session.sampleData.first!
    }

    var sessionNoExercises: Session {
        Session.sampleData[2]
    }
    
    var workoutStrength: Workout {
        Workout.sampleData[0]
    }

    var workoutStrengthNoSets: Workout {
        Workout.sampleData[1]
    }

    var workoutCardio: Workout {
        Workout.sampleData[2]
    }

    var workoutCardioNoData: Workout {
        Workout.sampleData[3]
    }

    var facility: Facility {
        Facility.sampleData.first!
    }

    var exercise: Exercise {
        return Exercise.sampleData.first!
    }
    
    private init(){
        let schema = Schema([
            Session.self,
            Workout.self,
            RepSet.self,
            Exercise.self,
            Facility.self,
            CardioSession.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true )
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData(){
        for ex in Exercise.sampleData {
            context.insert(ex)
        }

        for ex in Facility.sampleData {
            context.insert(ex)
        }

        for session in Session.sampleData {
            context.insert(session)
        }

        for workoutset in Workout.sampleData {
            context.insert(workoutset)
        }

        for exset in RepSet.sampleData {
            context.insert(exset)
        }

        for exset in CardioSession.sampleData {
            context.insert(exset)
        }

        Session.sampleData[0].facility = Facility.sampleData[0]
        Session.sampleData[1].facility = Facility.sampleData[1]
        Session.sampleData[2].facility = Facility.sampleData[2]

        // strength workouts
        Workout.sampleData[0].session = Session.sampleData[0]
        Workout.sampleData[1].session = Session.sampleData[0]

        RepSet.sampleData[0].workout = Workout.sampleData[0]
        RepSet.sampleData[1].workout = Workout.sampleData[0]
        RepSet.sampleData[2].workout = Workout.sampleData[0]
        // Workout.sampleData[1] = strength workout with no data

        // cardio workouts
        Workout.sampleData[2].session = Session.sampleData[1]
        Workout.sampleData[3].session = Session.sampleData[1]
        
        CardioSession.sampleData[0].workout = Workout.sampleData[2]
        Workout.sampleData[2].cardioSession = CardioSession.sampleData[0]
        // Workout.sampleData[3] = cardio workout with no data

        Session.sampleData[0].workouts = [Workout.sampleData[0], Workout.sampleData[1], Workout.sampleData[2], Workout.sampleData[3]]
    }
}
