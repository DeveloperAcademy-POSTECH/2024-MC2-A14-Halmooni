//
//  addStamp.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//
import SwiftUI

struct addStamp: View {
    @State private var showModal = false
    var tokenSum: Int
    var tokenUsed: Int
    
    var body: some View {
        HStack {
            VStack {
                Text("우표 추가하기")
                Button(action: {
                    showModal = true
                }, label: {
                    Image(systemName: "plus.app")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.primaryColor)
                })
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .sheet(isPresented: $showModal) {
                addStampDetail(tokenSum: tokenSum, tokenUsed: tokenUsed)
            }
        }
    }
}

#Preview {
    addStamp(tokenSum: 15, tokenUsed: 8)
}
