//
//  CurrentStamp.swift
//  Halmooni
//
//  Created by 추서연 on 5/20/24.
//

import SwiftUI

struct CurrentStamp: View {
    @Binding var tokenSum: Int
    @Binding var tokenUsed: Int
    
    var body: some View {
        VStack(alignment: .center) {
            Text("사용 가능 우표 수")
            HStack {
                Image(systemName: "heart.square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.gry)
                    .padding(16)
                
                Text("\(tokenSum - tokenUsed)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.prim)
                Text("개")
            }
            Text("올해 모은 우표 수: \(tokenSum)개")
                .font(.caption)
                .foregroundColor(Color.gry)
        }
        .frame(height: 131)
        .padding(16)
        .background(.section)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onChange(of: tokenSum, initial: true) { oldValue, newValue in
                    UserDefaults.standard.tokenSum = newValue
        }
        .shadow(color: .gry2, radius: 10, x: 0, y: 5)
    }
}


#Preview {
    CurrentStamp(tokenSum: .constant(UserDefaults.standard.tokenSum), tokenUsed: .constant(UserDefaults.standard.tokenUsed))
}
