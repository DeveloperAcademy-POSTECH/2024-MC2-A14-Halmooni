//
//  DiaryCollectionView.swift
//  Halmooni
//
//  Created by Lee Wonsun on 5/20/24.
//

import SwiftUI

struct DiaryCollectionView: View {
    let columns = [GridItem(.flexible(), spacing: 7), GridItem(.flexible())]
    let gridNums: [Int] = [1, 2, 3, 4, 5]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.bg
                    .ignoresSafeArea(.all)
                ScrollView{
                    VStack(spacing: -1){
                        //우표템플릿 상단+날짜(월)
                        ZStack{
                            Image(.post)
                                .resizable()
                                .frame(width: 361)
                                .padding(.top, 32)
                            HStack{
                                Text("5月")
                                    .font(.title2)
                                    .bold()
                                    .padding(.leading, 32)
                                    .padding(.top, 48)
                                Spacer()
                            }
                        }
                        //기록 LazyVGrid
                        NavigationLink(destination: DiaryDetailView(presenter: FlipCardPresenter()).ignoresSafeArea()) {
                            LazyVGrid(columns: columns, spacing: 16, content: {
                                ForEach(gridNums, id: \.self) { num in
                                    ZStack{
                                        Image(.exampleimg)
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
                                                    Text("7일")
                                                        .font(.headline)
                                                        .foregroundStyle(Color.white)
                                                        .padding(.trailing, 13)
                                                }
                                            }
                                        }
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            })
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
