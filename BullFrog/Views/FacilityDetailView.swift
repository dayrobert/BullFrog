import SwiftUI
import SwiftData

struct FacilityDetailView: View {
    @Bindable var activeFacility: Facility
    
    let isNew: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    init(activeFacility: Facility, isNew: Bool = false ) {
        self.activeFacility = activeFacility
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            LabeledContent {
              TextField("Name of the facility", text: $activeFacility.name)
            } label: {
              Text("Name:")
            }
        }
        .navigationTitle(isNew ? "New Facility" : "Facility")
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
                        context.delete(activeFacility)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview("New") {
    NavigationStack {
        FacilityDetailView( activeFacility: Facility(), isNew: true )
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Update") {
    NavigationStack {
        FacilityDetailView( activeFacility: SampleData.shared.facility, isNew: false )
    }
    .modelContainer(SampleData.shared.modelContainer)
}
