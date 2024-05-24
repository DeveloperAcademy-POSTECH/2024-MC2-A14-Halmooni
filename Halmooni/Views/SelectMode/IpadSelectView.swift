//
//  IpadSelectVIew.swift
//  Halmooni
//
//  Created by donghwan on 5/23/24.
//

import Foundation
import SwiftUI

struct IpadSelectView : View {
    
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        ZStack{
            if isUnlocked{
                GrandMotherMainView()
            } else {
                
                Color.section
                    .ignoresSafeArea(.all)
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.section, Color.sec.opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(.all)
                VStack(alignment:.leading, spacing: 16){
                    
                    Image(.logoTitle)
                        .padding(.horizontal, 30)
                    VStack(alignment: .leading, spacing: 16){
                        Text("손자와 할머니의 우편함")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 30)
                            .foregroundColor(.text)
                        Text("사용자 모드를 선택하고 시작해 주세요")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(.text)
                        Text("한번 선택한 후에는 수정이 불가합니다")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(.text)
                    }.padding(.all, 40)
                    
                    
                    VStack(spacing: 0){
                        IphoneUnlockSliderView(sliderImage: "👵🏻", name: "할머니", colorButton:  .section, colorUnderButton:.section.opacity(0.5), arrowImage: Image(systemName :"arrow.right"), rectangleWidth: 1000, isUnlocked: $isUnlocked )
                        IphoneUnlockSliderView(sliderImage: "👦🏻", name: "무니",  colorButton: .section, colorUnderButton: .section.opacity(0.5), arrowImage: Image(systemName: "arrow.right"), rectangleWidth: 240, isUnlocked: $isUnlocked)
                    }
                }
            }
        }
    }
    
    // MARK: - 슬라이딩 패드 구조체
    struct IpadUnlockSliderView: View {
        let sliderImage: String
        let name: String
        let colorButton: Color
        let colorUnderButton: Color
        let arrowImage: Image
        let rectangleWidth: CGFloat
        
        @State private var offset: CGFloat = 0
        @State private var isHide: Bool = false
        @Binding  var isUnlocked: Bool
        
        
        var body: some View {
            ZStack {
                if isUnlocked {
                    
                } else {
                    HStack{
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill((colorUnderButton))
                                .frame(width: 500, height: 152)
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 15, y: 2)
                            
                            HStack {
                                Text(name)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.text)
                                    .padding(.leading, 20)
                                    .frame(width: 110)
                                
                                if !isHide {
                                    arrowImage
                                        .font(.title)
                                }
                            }
                            RoundedRectangle(cornerRadius: 15)
                                .fill(colorButton)
                                .frame(width: 138, height: 138)
                                .padding(.leading, 5)
                                .overlay(
                                    Text(sliderImage)
                                        .dynamicTypeSize(.accessibility2)
                                        .font(.largeTitle)
                                ).offset(x: offset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            isHide = true
                                            if gesture.translation.width > 0 {
                                                offset = min(gesture.translation.width, UIScreen.main.bounds.width - 1015)
                                            }
                                        }
                                        .onEnded { gesture in
                                            isHide = false
                                            if gesture.translation.width >
                                                rectangleWidth * 9/10
                                            {
                                                isUnlocked = true
                                            }
                                            withAnimation {
                                                offset = 0
                                            }
                                        }
                                )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .padding()
        }
    }
}


#Preview {
    IpadSelectView()
}
