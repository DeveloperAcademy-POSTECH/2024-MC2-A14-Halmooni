//
//  IphoneSelectVIew.swift
//  Halmooni
//
//  Created by donghwan on 5/23/24.
//

import Foundation
import SwiftUI

struct IphoneSelectView : View {
    
    var body: some View {
        ZStack{
            Color.bg
                .ignoresSafeArea(.all)
            VStack{
                VStack(alignment: .leading){
                    Text("앱을 시작하기에 앞서\n사용할 모드를 선택해 주세요!")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.vertical)
                    Text("한번 선택한 후에는 수정이 불가합니다.")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }.padding(.horizontal, 16)
                Spacer()
                VStack(spacing: 0){
                    IphoneUnlockSliderView(sliderImage: "👵🏻", name: "할머니", colorButton:  .prim, colorUnderButton:.section, arrowImage: "SlideArrowIphone", rectangleWidth: 240 )
                    IphoneUnlockSliderView(sliderImage: "👦🏻", name: "무니",  colorButton: .sec, colorUnderButton: .section, arrowImage: "SlideArrowIphone", rectangleWidth: 240)
                }
                Spacer(minLength: 300)
            }
        }
    }
}

// MARK: - 슬라이딩 패드 구조체
struct IphoneUnlockSliderView: View {
    let sliderImage: String
    let name: String
    let colorButton: Color
    let colorUnderButton: Color
    let arrowImage: String
    
    
    let rectangleWidth: CGFloat
    //    var isPad: Bool = false
    
    @State private var offset: CGFloat = 0
    @State private var isUnlocked: Bool = false
    @State private var isHide: Bool = false
    
    var body: some View {
        ZStack {
            //            let rectangleWidth: CGFloat = isPad ? 400 : 200
            ////////
            if isUnlocked { // TODO: 추후 뷰 연결 필요
                
                Text("아이폰이지롱")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                //예시로 해놓음
            } else {
                HStack{
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill((colorUnderButton))
                            .frame(height: 110)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 15, y: 2)
                        HStack {
                            Text(name)
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.leading, 20)
                                .frame(width: 110)
                            
                            if !isHide {
                                Image(arrowImage)
                                    .font(.title)
                            }
                        }
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorButton)
                            .frame(width: 100, height: 100)
                            .padding(.leading, 5)
                            .overlay(
                                Text(sliderImage)
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle)
                            ).offset(x: offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        isHide = true
                                        //
                                        if gesture.translation.width > 0 {
                                            offset = min(gesture.translation.width, UIScreen.main.bounds.width - 174)
                                        }
                                    }
                                    .onEnded { gesture in
                                        isHide = false
                                        //
                                        if gesture.translation.width > /*UIScreen.main.bounds.width * 1/4*/
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

#Preview {
    IphoneSelectView()
}
