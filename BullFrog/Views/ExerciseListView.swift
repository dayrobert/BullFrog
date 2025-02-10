//
//  ExerciseDefinitionDetailView.swift
//  BullFrog
//
//  Created by Robert Day on 2/9/25.
//

import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) private var context

    @Query private var exercises: [Exercise]
    @State private var newExercise: Exercise?

    var body: some View {
        Group{
            if !exercises.isEmpty {
                List {
                    ForEach(exercises) { exercise in
                        NavigationLink {
                            ExerciseDetailView( activeExercise: exercise)
                        } label: {
                            Text( exercise.name )
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            } else {
                ContentUnavailableView("Add Exercises", systemImage: "calendar.badge.plus" )
            }
        }
        .navigationBarTitle("Exercises", displayMode: .inline)
        .toolbar {
            ToolbarItem {
                Button(action: addSession) {
                    Label("Add exercise", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newExercise){ exercise in
            NavigationStack {
                ExerciseDetailView( activeExercise: exercise, isNew: true)
            }
        }
        .interactiveDismissDisabled()
        
    }
    
    private func addSession() {
        let newExercise = Exercise(name: "New Exercise", category: .strength_training )
        context.insert( newExercise)
        self.newExercise = newExercise
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(exercises[index])
            }
        }
    }
}

#Preview("with data") {
    NavigationView{
        ExerciseListView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("No data") {
    NavigationView{
        ExerciseListView()
            .modelContainer(for: Session.self )
    }
}
