//
//  HalmooniApp.swift
//  Halmooni
//
//  Created by 문인범 on 5/19/24.
//

import SwiftUI

@main
struct HalmooniApp: App {
    var body: some Scene {
        let managedObject = PersistentController.shared
        
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, managedObject.container.viewContext)
        }
    }
}
