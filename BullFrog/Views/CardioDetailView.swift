import SwiftUI

struct CardioDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Environment(ApplicationData.self) private var appData
    
    @State var distance: Double?
    @State var duration: Double?
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private var isNew: Bool
    
    init( isNew: Bool = false ){
        self.isNew = isNew
    }
    
    var body: some View {
        Form{
            LabeledContent {
                TextField( "Distance", value: $distance, formatter: formatter )
            } label: {
                Text("Distance:")
            }

            LabeledContent {
                TextField( "Duration", value: $duration, formatter: formatter )
            } label: {
                Text("Duration:")
            }
        }
        .onAppear(perform: loadStateVariables)
    }
    
    private func loadStateVariables() {
        if let cardioSession = appData.selectedWorkout!.cardioSession {
            duration = cardioSession.duration
            distance = cardioSession.distance
        }
    }
    
    private func commitDataEntry() {
        if let cardioSession = appData.selectedWorkout!.cardioSession {
            cardioSession.duration = duration!
            cardioSession.distance = distance!
        } else {
            let cardioSession = CardioSession( workout: appData.selectedWorkout!, distance: distance!, duration: duration! )
            context.insert( cardioSession )
        }
        try? context.save()
        dismiss()
    }
}

#Preview("New") {
    @Previewable @State var appData = ApplicationData.shared
    appData.selectedWorkout = SampleData.shared.workoutStrengthNoSets

    struct PreviewView: View {
        var body: some View {
            CardioDetailView(isNew: true)
        }
    }
    
    var ret = PreviewView()
        .environment(appData)
        .modelContainer( SampleData.shared.modelContainer )
    
    return ret
}

#Preview("Existing") {
    @Previewable @State var appData = ApplicationData.shared
    appData.selectedWorkout = SampleData.shared.workoutCardio

    struct PreviewView: View {
        var body: some View {
            CardioDetailView(isNew: true)
        }
    }
    
    var ret = PreviewView()
        .environment(appData)
        .modelContainer( SampleData.shared.modelContainer )
    
    return ret
}
