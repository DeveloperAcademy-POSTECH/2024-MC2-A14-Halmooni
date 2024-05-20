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
            Text("\(tokenSum)개")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)

            HStack{
                Image(systemName: "star.square.on.square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color("PrimColor"))
                Text("남은 우표: \(tokenSum - tokenUsed + 1)개")
                    .font(.caption)
                    .foregroundColor(Color("GryColor"))   
                    .padding(16)
            }
        }
        .frame(width: 208, height: 131)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}


#Preview {
    CurrentStamp(tokenSum: 15, tokenUsed: 8)
}
