//
//  GrandMotherDetailView.swift
//  grandmother
//
//  Created by Kyu Im on 5/17/24.
//

import SwiftUI
import AVKit

struct GrandMotherDetailView: View {
    @Binding var showDetailView: Bool
    var animationNamespace: Namespace.ID
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    Text("2024년 5월 18일")
                        .dynamicTypeSize(.xxxLarge)
                        .font(.largeTitle.bold())
                        .padding(.leading, 50)
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            showDetailView = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .dynamicTypeSize(.xxxLarge)
                            .font(.title)
                            .foregroundColor(.prim)
                            .padding(.trailing, 50)
                    })
                }// 날짜 버튼
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .padding(.leading, 50)
                        .aspectRatio(3/4, contentMode: .fit)
                        .matchedGeometryEffect(id: "photo0", in: animationNamespace)
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .padding(.trailing, 50)
                        .aspectRatio(3/4, contentMode: .fit)
//                        .matchedGeometryEffect(id: "card", in: animationNamespace)
                } // 사진과 카드
                Spacer()
                AudioPlayerView()

                    
            }//VStack
        }
        
    }
}

struct GrandMotherDetailView_Previews: PreviewProvider {
    @State static var showDetailView = true
    @Namespace static var animationNamespace
    
    static var previews: some View {
        GrandMotherDetailView(showDetailView: $showDetailView, animationNamespace: animationNamespace)
    }
}

//#Preview {
//    GrandMotherDetailView($showDetailView)
//}
