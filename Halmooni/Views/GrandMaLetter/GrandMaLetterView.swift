//
//  GrandMaLetterView.swift
//  Halmooni
//
//  Created by Lee Wonsun on 5/28/24.
//

import SwiftUI

struct GrandMaLetterView: View {
    // TODO: 모델 연결 완료 후 해당 배열 지워주세요
    @State var recordUrlList: [String] = [
        "1번", "2번", "3번"
    ]
    
    // 클라우드 데이터 받아오기
    @FetchRequest(entity: Letter.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Letter.savedDate, ascending: true)])
    var Letters: FetchedResults<Letter>
    
    // 음성 재생상태
    @State var isPlayed: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                // 배경 색상
                Color.bg
                    .edgesIgnoringSafeArea(.all)
                
                // 녹음 리스트
//                List{
//                    ForEach(Letters) { letter in
//                        HStack{
//                            Text(dateNumberFormatter.string(from: letter.savedDate!))
//                            
//                            Button(action: {
//                                isPlayed = true
//                                // TODO: 녹음재생 기능 삽입 필요
//                            }, label: {
//                                Image(systemName: isPlayed ? "stop.fill" : "play.fill")
//                                    .font(.system(size: 17))
//                                    .foregroundStyle(Color.prim)
//                            })
//                        }
//                    }
//                }
                
                // TODO: 데이터 연결 후 아래는 지워주세요 (위에가 찐 데이터 연결 UI)
                List{
                    ForEach(recordUrlList, id: \.self) { letter in
                        HStack{
                            Text(letter)
                            
                            Spacer()
                            
                            Button(action: {
                                isPlayed.toggle()
                                // TODO: 녹음재생 기능 삽입 필요
                                
                            }, label: {
                                Image(systemName: isPlayed ? "stop.fill" : "play.fill")
                                    .font(.system(size: 17))
                                    .foregroundStyle(Color.prim)
                            })
                        }
                    }
                }
                
                
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .navigationTitle(Title.letter.name)
            }
        }
    }
    
    // MARK: - 날짜 변환기
    var dateNumberFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.DD"
        return formatter
    }
}

#Preview {
    GrandMaLetterView()
}
