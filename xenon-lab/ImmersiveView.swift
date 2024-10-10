//
//  ImmersiveView.swift
//  xenon-lab
//
//  Created by Elia Salerno on 10.10.2024.
//

import SwiftUI
import RealityKit
import RealityKitContent
import UmainSpatialGestures

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel
   
    @State var tileEntity = Entity()

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                
                if let tileEntityQuery = immersiveContentEntity.findEntity(
                    named: "sample_tile_4"
                ) {
                    tileEntity = tileEntityQuery
                                 
                }
                
            }
        }
        .onChange(of: tileEntity.position) { _, newValue in
            print(tileEntity.position)
            print(newValue)
        }
        .useDragGesture()
    }
}
