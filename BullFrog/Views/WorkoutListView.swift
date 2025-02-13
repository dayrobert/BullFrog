import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Environment(\.modelContext) private var context
    @Bindable var activeSession: Session
    @State private var newWorkout: Workout?

    var body: some View {
        if !activeSession.workouts.isEmpty {
            List {
                ForEach(activeSession.workouts) { workout in
                    NavigationLink {
                        WorkoutDetailView( activeWorkout: workout)
                    } label: {
                        Text( workout.exercise?.name ?? "No Exercise" )
                    }
                }
                .onDelete(perform: deleteItems)
            }
        } else {
            ContentUnavailableView("Add Workoout", systemImage: "figure.strengthtraining.traditional" )
        }
    }
    
    private func addWorkout() {
        let newWorkout = Workout( session: activeSession, exercise: nil  )
        context.insert( newWorkout)
        self.newWorkout = newWorkout
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(activeSession.workouts[index])
            }
        }
    }
}

#Preview("Default") {
    NavigationStack{
        WorkoutListView( activeSession: SampleData.shared.session)
    }
}

#Preview("No workouts") {
    WorkoutListView( activeSession: SampleData.shared.sessionNoExercises)
}
