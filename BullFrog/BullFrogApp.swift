//
//  BullFrogApp.swift
//  BullFrog
//
//  Created by Robert Day on 12/18/24.
//

import SwiftUI
import SwiftData

@main
struct BullFrogApp: App {
    var body: some Scene {
        WindowGroup {
            SessionListView()
        }
        .modelContainer(for:[Session.self, Workout.self, RepSet.self])
    }
}
