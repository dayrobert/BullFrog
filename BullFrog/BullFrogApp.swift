//
//  BullFrogApp.swift
//  BullFrog
//
//  Created by Robert Day on 12/18/24.
//

import SwiftUI
import SwiftData
import Observation

@Observable @MainActor
class ApplicationData: @unchecked Sendable {
    var selectedSession: Session?
    var selectedWorkout: Workout?
    var selectedRepSet: RepSet?
    
    static let shared: ApplicationData = ApplicationData()
    static let sharedPreview: ApplicationData = ApplicationData( selectedSession: SampleData.shared.session )
    
    private init( selectedSession: Session? = nil) { }
}
 
@main
struct BullFrogApp: App {
    @State private var appData = ApplicationData.shared

    var body: some Scene {
        WindowGroup {
            SessionListView()
        }
        .modelContainer(for:[Session.self, Workout.self, RepSet.self, Exercise.self, Facility.self, CardioSession.self])
        .environment(appData)
    }
}
