import SwiftUI
import SwiftData

struct SessionListView: View {
    @Environment(\.modelContext) private var context
    @Environment(ApplicationData.self) private var appData
    
    @Query private var sessions: [Session]
    @State private var selection: Session.ID? = nil
    
    var body: some View {
        @Bindable var appData = appData
        
        NavigationStack() {
            Group{
                if( sessions.isEmpty ){
                    ContentUnavailableView("Add Session", systemImage: "calendar.badge.plus" )
                } else {
                    ForEach (sessions) { session in 
                        NavigationLink {
                            SessionDetailView(sessionId: session.id )
                        } label: {
                            Text("\(session.timestamp.formatted())")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationDestination(for: String.self, destination: { viewID in
                if viewID == "SessionDetail" {
                    SessionDetailView()
                }
            })
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        SessionDetailView()
                    } label: {
                        Label("Add session", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar ){
                    NavigationLink{
                        ExerciseListView()
                    } label: {
                        Text("Exercises")
                    }
                }
                ToolbarItem(placement: .bottomBar ){
                    NavigationLink{
                        FacilityListView()
                    } label: {
                        Text("Facilities")
                    }
                }
            }
        }
    }
    
    private func addSession() {
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
    @Previewable @State var appData = ApplicationData.shared
    SessionListView()
        .environment(appData)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("No data") {
    @Previewable @State var appData = ApplicationData.shared
    SessionListView()
        .environment(appData)
        .modelContainer(for: Session.self )
}

