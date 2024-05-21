//
//  ContentView.swift
//  Halmooni
//
//  Created by 문인범 on 5/19/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GoalView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text(Title.goal.name)
                }
                .tag(0)
            
            DiaryCollectionView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text(Title.list.name)
                }
                .tag(1)
        }
        .tint(Color(.prim))
    }
}

#Preview {
    MainTabView()
}
