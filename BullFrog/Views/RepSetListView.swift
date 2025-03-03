import SwiftUI
import SwiftData

struct RepSetListView: View {
    @Environment(\.modelContext) var context
    @Environment(ApplicationData.self) private var appData

    @State var selection: RepSet.ID?
    
    var body: some View {
        @Bindable var appData = appData
        let selectedWorkout = appData.selectedWorkout!

        Group {
            if !(selectedWorkout.repSets.isEmpty) {
                List(selectedWorkout.repSets.sorted { $0.index < $1.index }, selection: $selection ) { repset in
                   NavigationLink {
                       RepSetDetailView( repsetId: repset.id )
                   } label: {
                        Text( repset.index.formatted() )
                    }
                }
                .onChange(of: selection, initial: false) { old, idRepSet in
                    appData.selectedRepSet = selectedWorkout.repSets.first(where: { $0.id == idRepSet })
                }
            } else {
                ContentUnavailableView("Add Set", systemImage: "figure.strengthtraining.traditional" )
            }
        }
        .toolbar {
            ToolbarItemGroup( placement: .bottomBar ) {
                NavigationLink {
                    RepSetDetailView()
                } label: {
                    Label("Add Workout Set", systemImage: "plus")
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(appData.selectedSession!.workouts[index])
            }
        }
    }
}
#Preview("Default") {
    struct PreviewWrapper: View {
        @State var appData = ApplicationData.shared
        
        var body: some View {
            RepSetListView()
            .environment(appData)
            .modelContainer(SampleData.shared.modelContainer)
        }
    }
    
    return PreviewWrapper()
}

#Preview("No workouts") {
    struct PreviewWrapper: View {
        @State var appData = ApplicationData.shared
        
        init(){
            appData.selectedSession = SampleData.shared.sessionNoExercises
        }
        
        var body: some View {
            RepSetListView()
                .modelContainer(SampleData.shared.modelContainer)
                .environment(appData)
        }
    }
    return PreviewWrapper()
}
