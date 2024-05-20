//
//  ContentView.swift
//  Halmooni
//
//  Created by 문인범 on 5/19/24.
//

import SwiftUI

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // TODO: - 목표관리 View 넣어주세요
            GoalView()
                .tabItem {
                    Image(systemName: "scope")
                    Text("목표 관리")
                }
            
            
            // TODO: - 모아보기 View 넣어주세요
            Text("모아보기뷰")
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("모아 보기")
                }
            
        }
        .tint(Color("PrimColor"))
    }
}

#Preview {
    MainTabView()
}
