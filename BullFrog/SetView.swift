//
//  SetView.swift
//  BullFrog
//
//  Created by Robert Day on 12/19/24.
//

import SwiftUI

struct SetView: View {
    @State var sets : Int = 1
    @State var reps : Int = 1
    
    var body: some View {
        HStack(  alignment: .top ) {
            Picker("Sets", selection: $sets ) {
                Text("1").tag(1)
            };
            Picker("Reps", selection: $reps ) {
                Text("1").tag(1)
            };
        }
        .toolbar {
            ToolbarItem(placement:.topBarLeading) {
                Text("tt")
            }
        }
    }
}

#Preview {
    SetView()
}
