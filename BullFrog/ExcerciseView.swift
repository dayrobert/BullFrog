//
//  ExcerciseView.swift
//  BullFrog
//
//  Created by Robert Day on 12/18/24.
//

import SwiftUI
import SwiftData

struct ExcerciseView: View {
    
    @State var selection: Int = 1
    @State var weight: Double = 0
    @State var reps: Int = 0
    @State var item: Item
    
    var excersizes: [String] = ["Treadmill", "Leg Press"]

    init( item: Item ) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            List {
                ForEach( excersizes) { excersize in
                    NavigationLink {
                        SetView()
                    } label: {
                        Text(excersize)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement:.topBarLeading) {
                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard) )
            }
        }
    }
}

extension String: @retroactive Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

#Preview {
    ExcerciseView( item: .init( timestamp: Date.now))
}

