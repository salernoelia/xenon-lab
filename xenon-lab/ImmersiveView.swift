//
//  ImmersiveView.swift
//  xenon-lab
//
//  Created by Elia Salerno on 10.10.2024.
//

import SwiftUI
import RealityKit
import RealityKitContent
import Combine
import UmainSpatialGestures

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel
    @State var tileEntity = Entity()
    @State var collision1Entity = Entity()
    @State var collision2Entity = Entity()
    @State private var subscription: EventSubscription?
    
    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                
                if let collision1EntityQuery = immersiveContentEntity.findEntity(named: "plate1") {
                    collision1Entity = collision1EntityQuery
                    print(collision1Entity)
                    
                    subscription = content.subscribe(to: CollisionEvents.Began.self, on: collision1Entity) { event in
                        print("Collision started between \(event.entityA.name) and \(event.entityB.name)")
                    }
                    subscription = content
                        .subscribe(
                            to: CollisionEvents.Ended.self,
                            on: collision1Entity
                        ) { event in
                        print("Collision ended between \(event.entityA.name) and \(event.entityB.name)")
                    }
                  
                }
                
                if let collision2EntityQuery = immersiveContentEntity.findEntity(named: "plate2") {
                    collision2Entity = collision2EntityQuery
                    print(collision2Entity)
                    
                    subscription = content.subscribe(to: CollisionEvents.Began.self, on: collision2Entity) { event in
                        print("Collision started between \(event.entityA.name) and \(event.entityB.name)")
                        
                    }
                    subscription = content.subscribe(to: CollisionEvents.Ended.self, on: collision2Entity) { event in
                        print("Collision started between \(event.entityA.name) and \(event.entityB.name)")
                        
                    }
                }

                if let tileEntityQuery = immersiveContentEntity.findEntity(named: "sample_tile_4") {
                    tileEntity = tileEntityQuery
                }
            }
        }
        .useDragGesture()
    }
    
    
    func logEntity(_ entity: Entity) {
        print("\(entity)")
    }
}
