//
//  DiaryDetailView.swift
//  Halmooni
//
//  Created by Seoyeon Choi on 5/21/24.
//

import SwiftUI

struct DiaryDetailView: View {
    @ObservedObject var presenter: FlipCardPresenter
    
    var body: some View {
        ZStack{
            Color.bg
            //기록카드 뷰
            ImageCard(presenter: presenter)
            //수정, 삭제하기 툴바
                .toolbar{
                    ToolbarItem{
                        Menu(content: {
                            Button(action: {
                                
                            }, label: {
                                HStack{
                                    Text("수정하기")
                                        .foregroundStyle(.gry)
                                    Image(systemName: "pencil")
                                        .foregroundStyle(.gry)
                                }
                            })
                            
                            Button(role: .destructive, action: {
                                
                            }, label: {
                                HStack{
                                    Text("삭제하기")
                                        .foregroundColor(.prim)
                                    Image(systemName: "trash.fill")
                                        .tint(.prim)
                                }
                            })
                        }, label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundStyle(.prim)
                        })
                    }
                }
        }
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea()
    }
}

// MARK: 상세보기뷰 - 우표템플릿
struct ImageCard: View {
    @ObservedObject var presenter: FlipCardPresenter
    @State private var isAnimating: Bool = false
    
    var body: some View {
        //우표템플릿
        VStack {
            Spacer()
            ZStack{
                Image(.fullPost)
                    .resizable()
                    .frame(width: 361, height: 571)
                //날짜, 음성재생 버튼
                VStack{
                    HStack{
                        Text("5월 7일")
                            .font(.title2)
                            .bold()
                            .padding(.leading, 32)
                        Spacer()
                        Button(action: {
                            //음성재생 기능 필요
                        }, label: {
                            PlayButton()
                                .foregroundStyle(.text)
                                .padding(.trailing, 32)
                        })
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                //카드 이미지
                FlipCard(presenter: presenter, isAnimating: $isAnimating)
                    .rotation3DEffect(.degrees(isAnimating ? 5 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(
                        isAnimating ?
                        Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true) : .default ,
                        value: isAnimating
                    )
                    .rotation3DEffect(.degrees(presenter.isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(.default, value: presenter.isFlipped)
                    .onAppear {
                        isAnimating = true
                    }
                    .onDisappear {
                        presenter.isFlipped = false //카드 뒤집힌 상태 초기화
                    }
            }
            .frame(width: 361, height: 571)
            Spacer()
                .frame(height: 112)
        }
    }
}

// MARK: 음성재생버튼
struct PlayButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 90)
                .frame(width: 90, height: 30)
                .foregroundStyle(.sec)
            HStack(spacing: 0){
                Text("음성 재생 ")
                    .font(.system(size: 13))
                Image(systemName: "play.circle")
                    .font(.system(size: 13))
            }
        }
    }
}

// MARK: 이미지카드 + 사용한 토큰
struct FlipCard: View {
    @ObservedObject var presenter: FlipCardPresenter
    @Binding var isAnimating: Bool
    
    var body: some View {
        ZStack{
            //이미지카드
            VStack{
                Spacer()
                Image(presenter.isFlipped ? .examplecard : .exampleimg)
                    .resizable()
                    .frame(width: 297, height: 457)
                    .scaleEffect(x: presenter.isFlipped ? -1 : 1, y: 1)
                    .overlay{
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                UsedToken()
                                    .padding(20)
                            }
                        }
                        .scaleEffect(x: presenter.isFlipped ? -1 : 1, y: 1)
                        .opacity(presenter.isFlipped ? 1 : 0)
                    }
                    .clipped()
                    .cornerRadius(15)
                    .scaledToFit()
                    .shadow(color: .gry, radius: 4, y: 4)
                    .padding(.bottom, 37)
                    .onTapGesture {
                        presenter.flipButtonTapped()
                        isAnimating = false
                    }
            }
        }
    }
}

// MARK: 카드플립을 위한 protocol, class
protocol FlipCardPresenterProtocol: ObservableObject {
    var isFlipped: Bool { get }
    func flipButtonTapped()
}

class FlipCardPresenter: FlipCardPresenterProtocol {
    @Published var isFlipped: Bool = false
    
    func flipButtonTapped() {
        isFlipped.toggle()
    }
}

// MARK: 사용한 토큰 갯수
struct UsedToken: View {
    var body: some View {
        ZStack{
            Image(.tokenpost)
                .resizable()
                .frame(width: 78, height: 52)
            HStack(spacing: 0){
                Image(systemName: "heart.fill")
                    .font(.system(size: 22))
                Text(" 17")
                    .font(.title2)
                    .bold()
                    .font(.system(size: 22))
            }
        }
    }
}
