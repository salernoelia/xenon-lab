//
//  AppModel.swift
//  xenon-lab
//
//  Created by Elia Salerno on 10.10.2024.
//

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    /// immersive space
    let immersiveSpaceID = "ImmersiveSpace"
    
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    
    var immersiveSpaceState: ImmersiveSpaceState = .closed
    
    /// tables
    enum TableState {
        case closed
        case open(TablePosition)
        case inTransition
    }

    enum TablePosition {
        case left
        case center
        case right
    }

    var tableState: TableState = .closed

    
    
}
