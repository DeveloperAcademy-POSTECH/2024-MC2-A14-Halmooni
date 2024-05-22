//
//  GuageBar.swift
//  Halmooni
//
//  Created by 추서연 on 5/20/24.
//

import SwiftUI

struct GaugeBar: View {
    @Binding var tokenSum: Int
    var tokenUsed : Int
    
    private var progress : Double {
        return Double(tokenUsed) / Double(tokenSum)}
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("할머니께 달려가는 길")
            
            Gauge(value: progress) {
                HStack{
                    Image(systemName: "figure.run")
                        .resizable()
                        .frame(width: 21, height: 28)
                        .offset(x: CGFloat(progress) * 360 - 150 , y: 0)
                    Image(systemName: "house.and.flag.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .offset(x: 130 , y: 0)
                }
            }
            .tint(Color.prim)
        }
        .padding(16)
        .background(.section)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    GaugeBar(tokenSum: .constant(15), tokenUsed: 0)
}
