import SwiftUI

struct RepSetDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Environment(ApplicationData.self) private var appData
    
    @State var reps: Int?
    @State var weight: Int?
    
    var repsetId: RepSet.ID? = nil
    
    init( repsetId: RepSet.ID? = nil) {
        self.repsetId = repsetId
    }

    var body: some View {
        let isNew: Bool = repsetId == nil

        Form{
            Picker("Reps", selection: $reps) {
                if( reps == nil ) {
                    Text("Select reps").tag(nil as Int?)
                }
                ForEach(1...15, id: \.self) { rep in
                    Text(rep.formatted()).tag(rep)
                }
            }
            
            Picker("Weight", selection: $weight) {
                if( weight == nil) {
                    Text("Select weight").tag(nil as Int?)
                }
                ForEach(50...200, id: \.self) { weight in
                    Text(weight.formatted()).tag(weight)
                }
            }
        }
        .navigationTitle(isNew ? "New Set" : "Set")
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
        if let repsetId = self.repsetId {
            for repset in appData.selectedWorkout!.repSets {
                if repset.id == repsetId {
                    appData.selectedRepSet = repset
                    break;
                }
            }
        } else {
            appData.selectedRepSet = nil
        }

        if let repset = appData.selectedRepSet {
            reps = repset.reps
            weight = repset.weight
        }
    }
    
    private func commitDataEntry() {
        if let repset = appData.selectedRepSet {
            repset.reps = reps!
            repset.weight = weight!
        } else {
            let index = appData.selectedWorkout!.repSets.count
            let repset = RepSet( workout: appData.selectedWorkout!, index: index, reps: reps!, weight: weight! )
            context.insert( repset )
        }
        try? context.save()
        dismiss()
    }
}

//#Preview("New") {
//    @Previewable @State var appData = ApplicationData.shared
//    NavigationStack {
//        RepSetDetailView()
//    }
//    .environment(appData)
//    .modelContainer( SampleData.shared.modelContainer )
//}
//
//#Preview("Old with Sets") {
//    @Previewable @State var appData = ApplicationData.shared
//    NavigationStack {
//        RepSetDetailView()
//    }
//    .environment(appData)
//    .modelContainer( SampleData.shared.modelContainer )
//}
