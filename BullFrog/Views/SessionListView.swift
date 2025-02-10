import SwiftUI
import SwiftData

struct SessionListView: View {
    @Environment(\.modelContext) private var context

    @Query private var sessions: [Session]
    @State private var newSession: Session?

    var body: some View {
        NavigationView {
            Group{
                if !sessions.isEmpty {
                    List {
                        ForEach(sessions) { session in
                            NavigationLink {
                                SessionDetailView( activeSession: session)
                            } label: {
                                Text(session.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                } else {
                    ContentUnavailableView("Add Session", systemImage: "calendar.badge.plus" )
                }
            }
            .navigationBarTitle("Workout Sessions", displayMode: .inline)
            .toolbar {
                ToolbarItem {
                    Button(action: addSession) {
                        Label("Add session", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarLeading ){
                    NavigationLink{
                        ExerciseListView()
                    } label: {
                        Text("Settings")
                    }
                }
            }
            .sheet(item: $newSession){ session in
                NavigationStack {
                    SessionDetailView( activeSession: session, isNew: true)
                }
            }
            .interactiveDismissDisabled()
        }
    }
    
    private func addSession() {
        let newSession = Session( timestamp: .now  )
        context.insert( newSession)
        self.newSession = newSession
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(sessions[index])
            }
        }
    }
}

#Preview {
    SessionListView()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("No data") {
    SessionListView()
        .modelContainer(for: Session.self )
}
