//
//  AddStamp.swift
//  Halmooni
//
//  Created by 추서연 on 5/20/24.
//

import SwiftUI

struct AddStamp: View {
    @State private var showModal = false
    @Binding var tokenSum: Int
    var tokenUsed: Int
    
    var body: some View {
        VStack {
            Text("우표 추가하기")
            Button(action: {
                showModal = true
            }, label: {
                Image(systemName: "plus.app")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.prim)
            })
        }
        .frame(width:127, height: 131)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .sheet(isPresented: $showModal) {
            AddStampDetail(tokenSum: $tokenSum, tokenUsed: tokenUsed)
        }
    }
}

#Preview {
    AddStamp(tokenSum: .constant(UserDefaults.standard.tokenSum), tokenUsed: UserDefaults.standard.tokenUsed)
}
