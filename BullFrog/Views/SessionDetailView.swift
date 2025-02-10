import SwiftUI
import SwiftData

struct SessionDetailView: View {
    @Bindable var activeSession: Session
    
    @Query private var workouts: [Workout]

    let isNew: Bool
    let facilityList: [String] = ["Other", "The Gym", "Home"]
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State private var newWorkout: Workout?

    init(activeSession: Session, isNew: Bool = false ) {
        self.activeSession = activeSession
        self.isNew = isNew
    }

    var body: some View {
        Form {
            DatePicker("Starting Time", selection: $activeSession.timestamp)
            Picker("Facility", selection: $activeSession.facility ){
                ForEach(facilityList, id: \.self) { facility in
                    Text(facility)
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
        let newWorkout = Workout( session: activeSession, name: "" )
        context.insert( newWorkout)
        self.newWorkout = newWorkout

    }
}

#Preview("New") {
    NavigationStack {
        SessionDetailView( activeSession: SampleData.shared.sessionNoExercises, isNew: true )
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Old with Sets") {
    NavigationStack {
        SessionDetailView( activeSession: SampleData.shared.session, isNew: false )
    }
    .modelContainer(SampleData.shared.modelContainer)
}
