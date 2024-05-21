//
//  GoalView.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//

import SwiftUI

struct GoalView: View {
    @State private var tokenSum = 15
    @State private var tokenUsed = 8
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.bg)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("목표 관리")
                        .padding(16)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    HStack {
                        CurrentStamp(tokenSum: tokenSum, tokenUsed: tokenUsed)
                            .padding(.trailing, 25)
                        
                        AddStamp(tokenSum: tokenSum, tokenUsed: tokenUsed)
                    }
                    GaugeBar()
                    CalendarView(month: Date())
                }
                .padding(16)
            }
            .navigationTitle(Title.goal.name)
        }
    }
}

#Preview {
    GoalView()
}
