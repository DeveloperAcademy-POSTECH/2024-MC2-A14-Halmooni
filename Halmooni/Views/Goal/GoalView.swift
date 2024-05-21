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
                    HStack {
                        CurrentStamp(tokenSum: $tokenSum, tokenUsed: tokenUsed)
                            .padding(.trailing, 25)
                        Spacer()
                        AddStamp(tokenSum: $tokenSum, tokenUsed: tokenUsed)
                    }
                    GaugeBar(tokenSum: $tokenSum, tokenUsed: tokenUsed)
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
