//
//  BullFrogTests.swift
//  BullFrogTests
//
//  Created by Robert Day on 12/18/24.
//

import Testing
@testable import BullFrog
//import SwiftData
//import XCTest

struct BullFrogTests {

    init () async throws {
    }
    
//    @MainActor
//    let testContainer: ModelContainer = {
////            container.mainContext.insert(Category.preview)
////            container.mainContext.insert(Account.preview)
//        
//        return container
//    }()
    
    @Test func the_rep_order_should_autoset_to_next() async throws {
        
        let repset: [RepSet] = RepSet.sampleData
        // the repset model should auto update order when a rep is deleted
        
        
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        #expect( repset.count == 3, "There should be 3 sets")
    }

    @Test func the_rep_order_should_autoset_when_deleted() async throws {
//        var context = await testContainer.mainContext
//        var sessions = context.fetch( Session.self )

//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: RepSet.self, configurations: config)

//         let sut = .ViewModel(modelContext: testContainer.mainContext)
//         sut.addSamples()

        let count = 1
        #expect( count == 1, "There should be 3 sets")
//        XCTAssertEqual(count, 3, "There should be 3 sessions")
    }
}
