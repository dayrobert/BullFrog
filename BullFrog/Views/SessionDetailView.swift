import SwiftUI
import SwiftData

struct SessionDetailView: View {
    @Query private var facilityList: [Facility]
    @Query private var allExercises: [Exercise]
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Environment(ApplicationData.self) private var appData

    @Query private var sessions: [Session]

    @State private var timestamp: Date = .now
    @State private var facility: Facility? = nil
    
    private var sessionId: Session.ID? = nil
    
    init( sessionId: Session.ID? = nil){
        self.sessionId = sessionId
    }
    
    var body: some View {
        let isNew: Bool = appData.selectedSession == nil
        
        Form {
            DatePicker("Starting Time", selection: $timestamp)
            
            Picker("Facility", selection: $facility ){
                if( facility == nil ) {
                    Text("Select a facility").tag(nil as Facility?)
                }
                ForEach(facilityList) { facility in
                    Text(facility.name)
                        .tag(facility)
                }
            }
            
            if !isNew {
                Section(header: Text("Workouts")) {
                    WorkoutListView()
                }
            }
        }
        .navigationTitle(isNew ? "New Workout Session" : "Workout Session")
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
        if let sessionId = self.sessionId {
            for session in sessions {
                if session.id == sessionId {
                    appData.selectedSession = session
                    break;
                }
            }
        } else {
            appData.selectedWorkout = nil
        }

        if let session = appData.selectedSession {
            timestamp = session.timestamp
            facility = session.facility
        }
    }
    
    private func commitDataEntry() {
        if let session = appData.selectedSession {
            session.timestamp = timestamp
            session.facility = facility
        } else {
            let session = Session( timestamp: timestamp, facility: facility )
            context.insert( session )
        }
        try? context.save()
        dismiss()
    }
}

#Preview("New") {
    @Previewable @State var appData = ApplicationData.shared
    NavigationStack {
        SessionDetailView()
    }
    .environment(appData)
    .modelContainer( for:[ Session.self, Workout.self] )
}

#Preview("Old with Sets") {
    @Previewable @State var appData = ApplicationData.shared
    NavigationStack {
        SessionDetailView()
    }
    .environment(appData)
    .modelContainer(SampleData.shared.modelContainer)
}
