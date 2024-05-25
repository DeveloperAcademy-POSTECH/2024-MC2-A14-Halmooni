//
//  GoalView.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//

import SwiftUI

struct GoalView: View {
    @State private var tokenSum = UserDefaults.standard.tokenSum
    @State private var tokenUsed = UserDefaults.standard.tokenUsed
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.bg)
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            CurrentStamp(tokenSum: $tokenSum, tokenUsed: $tokenUsed)
                            Spacer()
                            AddStamp(tokenSum: $tokenSum, tokenUsed: $tokenUsed)
                                
                        }
                        GaugeBar(tokenSum: $tokenSum, tokenUsed: $tokenUsed)
                        CalendarView(month: Date())
                    }
                    .padding(16)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle(Title.goal.name)
        }
        .onAppear {
            self.tokenSum = UserDefaults.standard.tokenSum
            self.tokenUsed = UserDefaults.standard.tokenUsed
        }
    }
}

extension UserDefaults {
    private enum Keys {
        static let tokenSum = "tokenSum"
        static let tokenUsed = "tokenUsed"
    }
    
    var tokenSum: Int {
        get { integer(forKey: Keys.tokenSum) }
        set { set(newValue, forKey: Keys.tokenSum) }
    }
    
    var tokenUsed: Int {
        get { integer(forKey: Keys.tokenUsed) }
        set { set(newValue, forKey: Keys.tokenUsed) }
    }
}

#Preview {
    GoalView()
}
