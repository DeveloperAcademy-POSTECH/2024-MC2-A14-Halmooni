//
//  DiaryCollectionView.swift
//  Halmooni
//
//  Created by Lee Wonsun on 5/20/24.
//

import SwiftUI

// MARK: (임시)PostDate Model
struct PostDate: Identifiable {
    let id = UUID()
    var date: Date
}

struct DiaryCollectionView: View {
    @State private var postdate: [String: [PostDate]] = [:] // 빈 배열로 초기화
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.bg
                    .ignoresSafeArea(.all)
                ScrollView {
                    ForEach(Array(postdate.keys), id: \.self) { key in
                        VStack(spacing: 0){
                            ZStack{
                                Image(.post)
                                    .resizable()
                                    .frame(width: 361)
                                    .padding(.top, 32)
                                HStack{
                                    Text("\(key)月")
                                        .font(.title2)
                                        .bold()
                                        .padding(.leading, 32)
                                        .padding(.top, 48)
                                    Spacer()
                                }
                            }
                            
                            NavigationLink(destination: DiaryDetailView(presenter: FlipCardPresenter()).ignoresSafeArea()) {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                    if let postList = postdate[key] {
                                        ForEach(postList) { post in
                                            ZStack{
                                                Image(.exampleimg) // TODO: 추후 교체
                                                    .resizable()
                                                    .frame(width: 161, height: 215)
                                                
                                                //날짜, 전송예약
                                                VStack{
                                                    Spacer()
                                                    ZStack{
                                                        Rectangle()
                                                            .frame(width: 161, height: 34)
                                                            .foregroundStyle(Color.black)
                                                            .opacity(0.5)
                                                        HStack(spacing: 0){
                                                            Spacer()
                                                            WillSendIndicatior()
                                                                .padding(.trailing, 16)
                                                            Text("7일") // TODO: 추후 교체
                                                                .font(.headline)
                                                                .foregroundStyle(Color.white)
                                                                .padding(.trailing, 13)
                                                        }
                                                    }
                                                }
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }
                                    }
                                }
                                .padding([.leading, .trailing], 32)
                                .padding(.bottom, 16)
                                .background{
                                    Rectangle()
                                        .foregroundStyle(.white)
                                        .frame(width: 361)
                                }
                            }
                            Spacer()
                        }
                    }
                    .onAppear{
                        loadPosts()
                    }
                }
            }
            .toolbarBackground(.bg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.accentColor)
            .toolbar{
                ToolbarItem{
                    Button(action: {
                        // MARK: 글쓰기 뷰 삽입 필요
                        print("+")
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.prim)
                    })
                }
            }
        }
    }
 
    // MARK: 날짜(월) - 숫자만 추출되도록
    private var monthNumberFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        return formatter
    }
    
    // MARK: (임시) 배열 내 데이터 추가
    private func loadPosts() {
        // 예시 데이터 로드 (네트워크 요청이나 데이터베이스 조회 대신 사용)
        let examplePostList = [
            monthNumberFormatter.string(from: Date()) : [
                PostDate(date: Date())
            ],
            monthNumberFormatter.string(from: Calendar.current.date(byAdding: .month, value: -1, to: Date())!) : [
                PostDate(date: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), // 1개월 전
                PostDate(date: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), // 1개월 전
            ],
            monthNumberFormatter.string(from: Calendar.current.date(byAdding: .month, value: -2, to: Date())!) : [
                PostDate(date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!) // 2개월 전
            ]
        ]
        postdate = examplePostList
    }
}

// MARK: 전송예약 아이콘
@ViewBuilder
func WillSendIndicatior() -> some View {
    ZStack{
        ZStack{
            RoundedRectangle(cornerRadius: 90)
                .foregroundStyle(.white)
                .frame(width: 90, height: 20)
            HStack(spacing: 0){
                Text("전송 예정 ")
                    .font(.caption2)
                    .foregroundStyle(.prim)
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.prim)
                
            }
        }
    }
}

#Preview {
    DiaryCollectionView()
}
