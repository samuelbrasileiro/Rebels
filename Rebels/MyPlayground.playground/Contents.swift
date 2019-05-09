import UIKit
enum Phase: Int{
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    
    mutating func nextPhase()->Phase{
        self = Phase(rawValue: self.rawValue + 1) ?? .first
        return self
    }
}

var phase: Phase = .first
print(phase)
phase.nextPhase()
print(phase)
phase.nextPhase()
print(phase)
phase.nextPhase()
print(phase)
phase.nextPhase()
print(phase)
phase.nextPhase()
print(phase)
phase.nextPhase()
print(phase)

