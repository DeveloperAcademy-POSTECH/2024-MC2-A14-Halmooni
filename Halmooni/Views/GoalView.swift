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
        ZStack {
            Color.bgColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    currentStamp(tokenSum: tokenSum, tokenUsed: tokenUsed)
                    Spacer()
                    addStamp(tokenSum: tokenSum, tokenUsed: tokenUsed)
                }
                gaugeBar()
                CalendarView(month: Date())
            }
            .padding(16)
        }
    }
}

// Preview code
import SwiftUI

#Preview {
    GoalView()
}
