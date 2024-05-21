//
//  ContentView.swift
//  Halmooni
//
//  Created by 문인범 on 5/19/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Title = .goal

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                GoalView()
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text(Title.goal.name)
                    }
                    .tag(Title.goal)

                // TODO: - 모아보기 View 넣어주세요
                Text("모아보기뷰")
                    .tabItem {
                        Image(systemName: "square.grid.2x2.fill")
                        Text(Title.list.name)
                    }
                    .tag(Title.list)
            }
            .tint(Color(.prim))
            .navigationTitle(selectedTab.name)
        }
    }
}

#Preview {
    MainTabView()
}
