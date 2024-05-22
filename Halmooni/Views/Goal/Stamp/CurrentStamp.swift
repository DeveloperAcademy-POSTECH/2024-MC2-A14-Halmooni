//
//  CurrentStamp.swift
//  Halmooni
//
//  Created by 추서연 on 5/20/24.
//

import SwiftUI

struct CurrentStamp: View {
    @Binding var tokenSum: Int
    var tokenUsed: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("올해 모은 우표의 개수")
            Text("\(tokenSum)개")
                .fontWeight(.bold)
            
            HStack {
                Image(systemName: "star.square.on.square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.prim)
                Text("남은 우표: \(tokenSum - tokenUsed)개")
                    .font(.caption)
                    .foregroundColor(Color.gry)
                    .padding(16)
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    CurrentStamp(tokenSum: .constant(15), tokenUsed: 8)
}
