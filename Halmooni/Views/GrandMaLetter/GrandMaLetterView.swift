//
//  GrandMaLetterView.swift
//  Halmooni
//
//  Created by Lee Wonsun on 5/28/24.
//

import SwiftUI

struct GrandMaLetterView: View {
    @State private var audioController: AudioController = AudioController()
    @State private var isPlayed: Bool = false
    @State private var isLoading: Bool = false
    @State private var selectedDate: Date?

    // 클라우드 데이터 받아오기
    @FetchRequest(entity: Letter.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Letter.savedDate, ascending: false)])
    var Letters: FetchedResults<Letter>
    
    var body: some View {
        NavigationStack{
            ZStack{
                // 배경 색상
                Color.bg
                    .edgesIgnoringSafeArea(.all)
                
                // 녹음 리스트
                List{
                    ForEach(Letters) { letter in
                        
                        HStack{
                            Text(dateNumberFormatter.string(from: letter.savedDate!))
                            
                            Spacer()
                            
                            Button(action: {
                                if !audioController.isPlaying {
                                    guard let urlString = letter.recordUrl else {
                                        return
                                    }
                                    
                                    do {
                                        let filePath = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents")
                                        let name = urlString.split(separator: "/").last!
                                        let file = filePath?.appending(path: name)
                                        
                                        self.selectedDate = letter.savedDate!
                                        audioController.fileURL = file
                                        
                                        try FileManager.default.startDownloadingUbiquitousItem(at: file!)
                                        isLoading = true
                                    } catch {
                                        print("Failed to download Item, \(error.localizedDescription)")
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        audioController.startAudioWithLetter()
                                        isLoading = false
                                    }
                                } else {
                                    audioController.stopAudio()
                                }
                            }, label: {
                                if letter.savedDate == self.selectedDate {
                                    if audioController.isPlaying {
                                        Image(systemName: "stop.fill")
                                            .font(.system(size: 17))
                                            .foregroundStyle(.prim)
                                    } else if isLoading {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                    } else {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 17))
                                            .foregroundStyle(.prim)
                                    }
                                } else {
                                    Image(systemName: "play.fill")
                                        .font(.system(size: 17))
                                        .foregroundStyle(.prim)
                                }
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
    let dateNumberFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}

#Preview {
    GrandMaLetterView()
}
