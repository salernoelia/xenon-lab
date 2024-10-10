//
//  xenon_labApp.swift
//  xenon-lab
//
//  Created by Elia Salerno on 10.10.2024.
//

import SwiftUI

@main
struct xenon_labApp: App {
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var immersionStyle: ImmersionStyle = .mixed
    
    
    
    @State private var appModel = AppModel()
    @State private var avPlayerViewModel = AVPlayerViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
                .task {
                    await onAppStart()
                    
                }
        }
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(
            selection: $immersionStyle,
            in: .mixed,
            .progressive,
            .full
        )
    }
    
    func onAppStart() async {
        await openImmersiveSpace(id: appModel.immersiveSpaceID)
    }
}
