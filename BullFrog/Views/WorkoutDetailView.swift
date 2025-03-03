import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Query private var allExercises: [Exercise]
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Environment(ApplicationData.self) private var appData
    
    @State var exercise: Exercise? = nil
    
    private var workoutId: Workout.ID?
    
    init( workoutId: Workout.ID? = nil) {
        self.workoutId = workoutId
    }
    
    var body: some View {
        let isNew: Bool = appData.selectedWorkout == nil

        Form {
            Picker("Exercise:", selection: $exercise) {
                if( exercise == nil ) {
                    Text("Select an exercise").tag(nil as Exercise?)
                }
                ForEach( allExercises ) { exercise in
                    Text(exercise.name)
                        .tag(exercise)
                }
            }
            
            if !isNew {
                Section(header: Text("Sets")) {
                    RepSetListView()
                }
            }
        }
        .navigationTitle(isNew ? "New Workout" : "Workout")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
            Button(action : { dismiss() }){
                Text("Cancel")
            },
            trailing:
            Button(action : { commitDataEntry() }){
                Text("Save")
        })
        .onAppear(perform: loadStateVariables)
    }
    
    private func loadStateVariables() {
        if let workoutId = self.workoutId {
            for workout in appData.selectedSession!.workouts {
                if workout.id == workoutId {
                    appData.selectedWorkout = workout
                    break;
                }
            }
        } else {
            appData.selectedWorkout = nil
        }

        if let workout = appData.selectedWorkout {
            exercise = workout.exercise
        }
    }
    
    private func commitDataEntry() {
        if let workout = appData.selectedWorkout {
            workout.exercise = exercise!
        } else {
            let workout = Workout( session: appData.selectedSession!, exercise: exercise! )
            context.insert( workout )
        }
        try? context.save()
        
        dismiss()
    }
}

/*
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
*/
