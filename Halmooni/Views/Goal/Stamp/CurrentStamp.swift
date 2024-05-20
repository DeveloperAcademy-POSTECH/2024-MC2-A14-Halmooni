//
//  CurrentStamp.swift
//  Halmooni
//
//  Created by 추서연 on 5/20/24.
//

import SwiftUI

struct CurrentStamp: View {
    var tokenSum: Int
    var tokenUsed: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("올해 모은 우표의 개수")
                .font(.body)
            Text("\(tokenSum)개")
                .font(.body)
                .fontWeight(.bold)
            
            HStack(alignment: .bottom) {
                Image(systemName: "star.square.on.square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(.prim))
                    .padding(.trailing, 16)
                
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
    CurrentStamp(tokenSum: 15, tokenUsed: 8)
}
