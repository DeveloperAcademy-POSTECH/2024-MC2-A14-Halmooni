//
//  guageBar.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//

import SwiftUI

struct gaugeBar: View {
    
    @State private var progress = 0.6

    var body: some View {
        VStack {
            Text("할머니께 편지를 전달하러 가는 중이에요")
            
            Gauge(value: progress) {
                HStack{
                    Image(systemName: "figure.run")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .offset(x: CGFloat(progress) * 300 - 150 , y: 0)
                    Image(systemName: "house.and.flag.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .offset(x: 150 , y: 0)
                }
                                    
            }
            .tint(.primaryColor)
            .frame(width: 300, height: 20)
            .padding(16)
            
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    gaugeBar()
}
