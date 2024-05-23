//
//  HalmooniApp.swift
//  Halmooni
//
//  Created by 문인범 on 5/19/24.
//
import SwiftUI

@main
struct HalmooniApp: App {
    @State private var showSplash = true
    
    var body: some Scene {
        let managedObject = PersistentController.shared
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
                } else {
                    MainTabView()
                        .environment(\.managedObjectContext, managedObject.container.viewContext)
                }
            }
//            GrandMotherMainView()
//                .environment(\.managedObjectContext, managedObject.container.viewContext)
        }
    }
}
