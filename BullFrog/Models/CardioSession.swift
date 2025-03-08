import Foundation
import SwiftData

@Model
final class CardioSession: Identifiable {
    @Relationship(deleteRule: .cascade) var workout: Workout? = nil
    
    var distance: Double;
    var duration: Double;
    
    init(distance: Double, duration: Double){
        self.distance = distance
        self.duration = duration
    }
    
    init( workout: Workout, distance: Double, duration: Double){
        self.workout = workout
        self.distance = distance
        self.duration = duration
    }
    
    static let sampleData = [
        CardioSession( distance: 3.4, duration: 45.2 ),
        CardioSession( distance: 1.4, duration: 15 ),
        CardioSession( distance: 2.25, duration: 32.10 )
    ]
}

