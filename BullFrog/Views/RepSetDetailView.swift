import SwiftUI

struct RepSetDetailView: View {
    @Bindable var activeRepSet: RepSet

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    private var isNew: Bool

    init ( activeRepSet: RepSet, isNew: Bool = false) {
        self.isNew = isNew
        self.activeRepSet = activeRepSet
    }
    
    var body: some View {
        Form{
            Picker("Reps", selection: $activeRepSet.reps) {
                ForEach(1...15, id: \.self) { rep in
                    Text(rep.formatted())
                }
            }

            Picker("Weight", selection: $activeRepSet.weight) {
                ForEach(50...200, id: \.self) { weight in
                    Text(weight.formatted())
                }
            }
        }
        .navigationTitle(isNew ? "New Set" : "Set")
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
                        context.delete(activeRepSet)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview("Default") {
    RepSetDetailView( activeRepSet: SampleData.shared.workout.repSets[0])
}

#Preview("New") {
    RepSetDetailView( activeRepSet: SampleData.shared.workout.repSets[0], isNew: true)
}
