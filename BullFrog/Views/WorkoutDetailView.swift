import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Bindable var activeWorkout: Workout
    
    let isNew: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State private var newRepSet: RepSet?

    init(activeWorkout: Workout, isNew: Bool = false ) {
        self.activeWorkout = activeWorkout
        self.isNew = isNew
    }

    var body: some View {
        Form {
            TextField("Exercise:", text: $activeWorkout.name )
                .autocorrectionDisabled()
            
            if !isNew {
                Section("Sets") {
                    if !activeWorkout.repSets.isEmpty {
                        ForEach( activeWorkout.repSets ) { set in
                            NavigationLink {
                                RepSetDetailView(activeRepSet: set)
                            } label: {
                                Text(set.reps.formatted())
                            }
                        }
                    } else {
                        ContentUnavailableView("Add Sets", systemImage: "person.and.person" )
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Workout" : "Workout")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if isNew {
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        context.delete(activeWorkout)
                        dismiss()
                    }
                }
            } else {
                ToolbarItem {
                    Button(action: addSet) {
                        Label("Add Set", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .sheet(item: $newRepSet){ repset in
            NavigationStack {
                RepSetDetailView( activeRepSet: repset, isNew: true)
            }
        }
        .interactiveDismissDisabled()
    }
        
    private func addSet() {
        let newRepSet = RepSet( workout: activeWorkout, number: 1 )
        context.insert( newRepSet)
        self.newRepSet = newRepSet
    }
}

#Preview("New") {
    NavigationStack {
        WorkoutDetailView( activeWorkout: SampleData.shared.workoutNoSets, isNew: true )
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Old with Sets") {
    NavigationStack {
        WorkoutDetailView( activeWorkout: SampleData.shared.workout, isNew: false )
    }
    .modelContainer(SampleData.shared.modelContainer)
}
