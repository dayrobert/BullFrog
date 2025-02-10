//
//  FacilityDefinitionDetailView.swift
//  BullFrog
//
//  Created by Robert Day on 2/9/25.
//

import SwiftUI
import SwiftData

struct FacilityListView: View {
    @Environment(\.modelContext) private var context

    @Query private var exercises: [Facility]
    @State private var newFacility: Facility?

    var body: some View {
        Group{
            if !exercises.isEmpty {
                List {
                    ForEach(exercises) { exercise in
                        NavigationLink {
                            FacilityDetailView( activeFacility: exercise)
                        } label: {
                            Text( exercise.name )
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            } else {
                ContentUnavailableView("Add Facilities", systemImage: "building.fill" )
            }
        }
        .navigationBarTitle("Facilities", displayMode: .inline)
        .toolbar {
            ToolbarItem {
                Button(action: addSession) {
                    Label("Add facility", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newFacility){ exercise in
            NavigationStack {
                FacilityDetailView( activeFacility: exercise, isNew: true)
            }
        }
        .interactiveDismissDisabled()
        
    }
    
    private func addSession() {
        let newFacility = Facility(name: nil )
        context.insert( newFacility)
        self.newFacility = newFacility
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(exercises[index])
            }
        }
    }
}

#Preview("with data") {
    NavigationView{
        FacilityListView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("No data") {
    NavigationView{
        FacilityListView()
            .modelContainer(for: Session.self )
    }
}
