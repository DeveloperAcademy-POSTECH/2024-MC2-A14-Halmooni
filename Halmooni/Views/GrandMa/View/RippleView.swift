//
//  RippleView.swift
//  Halmooni
//
//  Created by Kyu Im on 5/29/24.
//

import SwiftUI

struct RippleView: View {
    @State private var outerRadius: CGFloat = 30
    @State private var outerOpacity: CGFloat = 1
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: outerRadius)
                .foregroundStyle(.prim)
                .opacity(1.7 - outerOpacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                        outerRadius = 70
                        outerOpacity = 2
                    }
                }
            
            Circle()
                .frame(width: 30)
                .foregroundStyle(.prim)
            
        }
    }
}
