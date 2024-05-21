//
//  AudioVisualizerView.swift
//  Halmooni
//
//  Created by 문인범 on 5/21/24.
//

import SwiftUI

struct AudioVisualizerView: View {
    @State public var value: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [.prim, .sec], startPoint: .top, endPoint: .bottom))
                .frame(width: (UIScreen.main.bounds.width - CGFloat(10) * 4) / CGFloat(10), height: value)
        }
    }
}
