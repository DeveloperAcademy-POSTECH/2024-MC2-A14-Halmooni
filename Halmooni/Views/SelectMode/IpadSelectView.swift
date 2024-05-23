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
                
                Color.bg
                    .ignoresSafeArea(.all)
                VStack{
                    VStack{
                        HStack{
                            Text("앱을 시작하기에 앞서 사용할 모드를 선택해 주세요!")
                                .dynamicTypeSize(.accessibility4)
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.vertical)
                                .foregroundColor(.text)
                            Spacer()
                        }.padding(.vertical,36)
                            .padding(.bottom,-36)
                            .padding(.horizontal,50)
                        HStack{
                            Text("한번 선택한 후에는 수정이 불가합니다.")
                                .dynamicTypeSize(.xxxLarge)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.text)
                            
                            Spacer()
                        }
                        .padding(.horizontal,50)
                        
                    }
                    Spacer()
                    VStack(spacing: 0){
                        IpadUnlockSliderView(sliderImage: "👵🏻", name: "할머니", colorButton: .prim, colorUnderButton: .section, arrowImage: Image(.slideArrowIpad), rectangleWidth: 390, isUnlocked: $isUnlocked)
                        IpadUnlockSliderView(sliderImage: "👦🏻", name: "무니",  colorButton: .prim, colorUnderButton: .section, arrowImage: Image(.slideArrowIpad), rectangleWidth: 2000, isUnlocked: $isUnlocked)
                    }
                    Spacer(minLength: 300)
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
