//
//  currentStamp.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//


import SwiftUI

struct currentStamp: View {
    var tokenSum: Int
    var tokenUsed: Int

    var body: some View {
        VStack {
            Text("올 해 모은 우표의 개수")
            Text("\(tokenSum)")
            HStack {
                Image(systemName: "star.square.on.square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.primaryColor)
                Text("남은 우표: \(tokenSum - tokenUsed + 1)개")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    currentStamp(tokenSum: 15, tokenUsed: 8)
}
