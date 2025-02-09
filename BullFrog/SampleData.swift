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
    
    var workout: Workout {
        Workout.sampleData.first!
    }

    var workoutNoSets: Workout {
        Workout.sampleData[3]
    }

    private init(){
        let schema = Schema([
            Session.self,
            Workout.self,
            RepSet.self
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
        for session in Session.sampleData {
            context.insert(session)
        }

        for workoutset in Workout.sampleData {
            context.insert(workoutset)
        }

        for exset in RepSet.sampleData {
            context.insert(exset)
        }

        Workout.sampleData[0].session = Session.sampleData[0]
        Workout.sampleData[1].session = Session.sampleData[0]

        Workout.sampleData[2].session = Session.sampleData[1]
        Workout.sampleData[3].session = Session.sampleData[1]
        
        RepSet.sampleData[0].workout = Workout.sampleData[0]
        RepSet.sampleData[1].workout = Workout.sampleData[0]
        RepSet.sampleData[2].workout = Workout.sampleData[0]
    }
}
