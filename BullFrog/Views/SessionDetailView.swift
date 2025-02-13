import SwiftUI
import SwiftData

struct SessionDetailView: View {
    @Bindable var activeSession: Session
    
    @Query private var workouts: [Workout]
    @Query private var facilityList: [Facility]
    @Query private var allExercises: [Exercise]

    let isNew: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State private var newWorkout: Workout?
    @State private var exercise: Exercise? = nil

    init(activeSession: Session, isNew: Bool = false ) {
        self.activeSession = activeSession
        self.isNew = isNew
    }

    var body: some View {
        Form {
            DatePicker("Starting Time", selection: $activeSession.timestamp)
            Picker("Exercise:", selection: $exercise) {
                if( exercise == nil ) {
                    Text("Select an exercise").tag(nil as Exercise?)
                }
                ForEach( allExercises ) { exercise in
                    Text(exercise.name)
                        .tag(exercise)
                }
            }

            Picker("Facility", selection: $activeSession.facility ){
                if( activeSession.facility == nil ) {
                    Text("Select a facility").tag(nil as Facility?)
                }
                ForEach(facilityList) { facility in
                    Text(facility.name)
                        .tag(facility)
                }
            }
            
            if !isNew {
                Section(header: Text("Workouts")) {
                    WorkoutListView( activeSession: activeSession )
                }
            }
        }
        .navigationTitle(isNew ? "New Workout Session" : "Workout Session")
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
                        context.delete(activeSession)
                        dismiss()
                    }
                }
            } else {
                ToolbarItem {
                    Button(action: addWorkout) {
                        Label("Add Workout Set", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .sheet(item: $newWorkout){ workout in
            NavigationStack {
                WorkoutDetailView( activeWorkout: workout, isNew: true )
            }
        }
        .interactiveDismissDisabled()
    }
    
    private func addWorkout() {
        let newWorkout = Workout( session: activeSession, exercise: nil )
        context.insert( newWorkout)
        self.newWorkout = newWorkout

    }
}

#Preview("New") {
    NavigationStack {
        SessionDetailView( activeSession: Session( timestamp: .now), isNew: true )
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Old with Sets") {
    NavigationStack {
        SessionDetailView( activeSession: SampleData.shared.session, isNew: false )
    }
    .modelContainer(SampleData.shared.modelContainer)
}
