//
//  ProgressBar.swift
//  grandmother
//
//  Created by Kyu Im on 5/19/24.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat // 0.0에서 1.0 사이의 값으로 진행률을 나타냅니다.

        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 4) // ProgressBar의 기본 배경
                        .foregroundColor(.gry2) // 기본 배경의 색상

                    Rectangle()
                        .frame(width: min(max(0, geometry.size.width * progress), geometry.size.width), height: 4) // 진행률에 따라 너비를 조절하는 프로그레스 바
                        .foregroundColor(.gry) // 프로그레스 바의 색상
                }
            }
        }
}

//#Preview {
//    ProgressBar()
//}
