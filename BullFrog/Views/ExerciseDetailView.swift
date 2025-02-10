import SwiftUI
import SwiftData

struct ExerciseDetailView: View {
    @Bindable var activeExercise: Exercise
    
    let isNew: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    init(activeExercise: Exercise, isNew: Bool = false ) {
        self.activeExercise = activeExercise
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            LabeledContent {
              TextField("Name", text: $activeExercise.name)
            } label: {
              Text("Name:")
            }

            Picker("Category:", selection: $activeExercise.category ){
                ForEach( ExerciseCategory.allCases, id: \.self) { value in
                    Text(value.name)
                        .tag(value)
                }
            }
        }
        .navigationTitle(isNew ? "New Exercise" : "Exercise")
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
                        context.delete(activeExercise)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview("New") {
    NavigationStack {
        ExerciseDetailView( activeExercise: SampleData.shared.exercise, isNew: true )
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Update") {
    NavigationStack {
        ExerciseDetailView( activeExercise: SampleData.shared.exercise, isNew: false )
    }
    .modelContainer(SampleData.shared.modelContainer)
}
