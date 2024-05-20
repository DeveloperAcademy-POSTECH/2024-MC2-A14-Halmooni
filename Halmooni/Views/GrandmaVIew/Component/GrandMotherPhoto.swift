//
//  GrandMotherPhoto.swift
//  grandmother
//
//  Created by Kyu Im on 5/18/24.
//

import SwiftUI

struct GrandMotherPhoto: View {
    var body: some View {
            ZStack {
                // 뒤에 있는 roundedRectangle
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(.green)
                    .aspectRatio(3/4, contentMode: .fit)
                
                // 앞에 있는 roundedRectangle
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(Color.black.opacity(0.5))
//                    .clipShape(OverlayShape())
                    .scaleEffect(x: 1, y: 1/6) // 가로 방향은 유지, 세로 방향은 1/6 축소
                    .offset(y: 410) // 앞에 있는 사각형을 뒤에 있는 사각형의 아래에 위치시키기 위한 오프셋
                    .aspectRatio(3/4, contentMode: .fit)
                HStack {
                    Text("15")
                        .offset(x: 270,y:410)
                        .dynamicTypeSize(.accessibility5)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("일")
                        .offset(x:272, y:412)
                        .dynamicTypeSize(.accessibility1)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        }
            }
                
            
        
    }
}

#Preview {
    GrandMotherPhoto()
}
