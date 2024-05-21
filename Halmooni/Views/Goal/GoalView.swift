//
//  GoalView.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//

import SwiftUI

struct GoalView: View {
    @State private var tokenSum = 15
    @State private var tokenUsed = 2
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("목표 관리")
                    .padding(16)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                HStack {
                    CurrentStamp(tokenSum: $tokenSum, tokenUsed: tokenUsed)
                    Spacer()
                    AddStamp(tokenSum: $tokenSum, tokenUsed: tokenUsed)
                }
                GaugeBar(tokenSum: $tokenSum, tokenUsed: tokenUsed)
                CalendarView(month: Date())
            }
            .padding(16)
        }
    }
}

#Preview {
    GoalView()
}
