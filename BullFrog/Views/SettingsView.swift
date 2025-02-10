//
//  SettingsView.swift
//  BullFrog
//
//  Created by Robert Day on 2/10/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView{
            Tab("Exerciese", systemImage: "dumbbell.fill"){
                ExerciseListView()
            }
            
            Tab("Facilities", systemImage: "building.fill"){
                ExerciseListView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
