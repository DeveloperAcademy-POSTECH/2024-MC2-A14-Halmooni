import SwiftUI
import UIKit


extension UserDefaults {
    var gifClicked: Bool {
        get {
            return bool(forKey: "gifClicked")
        }
        set {
            set(newValue, forKey: "gifClicked")
        }
    }
}

//HEX code 색상
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}


//detailView 호출시 블러 처리하는 것
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

struct GrandMotherMainView: View {
    @State private var select: Bool = false
    @State private var showDetailView: Bool = false
    @State private var isSaveClicked: Bool = false
    @State private var isSendClicked: Bool = false
    @Namespace private var animationNameSpace
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    private let phoneNumber = "010-5594-7259"
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private var imageColorScheme: Image {
        colorScheme == .dark ? Image(.halviewdark) : Image(.halviewlight)
    }
    
    
    @FetchRequest(entity: Diary.entity(), sortDescriptors: [.init(keyPath: \Diary.savedDate, ascending: false)])
    var diaries:FetchedResults<Diary>
    
    @State var selectedDiary: Diary?
    @State var selectedIndex: Int?
    
    @State private var audioController: AudioController = AudioController()
    @State private var isStopSelected: Bool = false
    @State private var id: UUID?
    
    var body: some View {
        
        ZStack {
            
            Color.section.ignoresSafeArea()
            
            //            imageColorScheme
            VStack {
                Rectangle()
                    .frame(height: 246)
                    .foregroundStyle(Color.bg)
                    .ignoresSafeArea()
                
                Spacer()
            }
            VStack {
                HStack {
                    Button(action: {
                        self.id = UUID()
                        audioController.startRecording(id: self.id!)
                        
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(.section)
                                .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.black, lineWidth: 5)
                                )
                            
                            
                            HStack {
                                Text("인범이에게 목소리 남기기")
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.text)
                                    .padding(.trailing, 12)
                                
                                Image(systemName: "mic.circle.fill")
                                    .foregroundColor(.blue)
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle)
                                    .padding()
                            }
                            
                        }
                        .frame(width: 573, height: 92)
                        
                    }
                    .padding(.top, 81)
                    .padding(.leading, 77)
                    // TODO: 전화 연결 클라우드 사용 방안으로 변경
                    
                    Spacer()
                    
                    if !audioController.isRecording && !self.isStopSelected {
                        Button(action: {
                            makeFaceTimeAudioCall(phoneNumber: phoneNumber)
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(.section)
                                    .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color.black, lineWidth: 5)
                                    )
                                
                                
                                HStack {
                                    Text("인범이에게 전화하기")
                                        .dynamicTypeSize(.xxxLarge)
                                        .font(.largeTitle.bold())
                                        .foregroundColor(.text)
                                        .padding(.leading, 44)
                                    
                                    
                                    
                                    Image(systemName: "phone.circle.fill")
                                        .foregroundColor(.green)
                                        .dynamicTypeSize(.xxxLarge)
                                        .font(.largeTitle)
                                        .padding(.trailing, 44)
                                }
                                
                            }
                            .frame(width: 573, height: 92)
                            
                        }
                        .padding(.top, 90)
                        .padding(.trailing, 77)
                    } else {
                        HStack {
                            Button {
                                audioController.stopRecording()
                                audioController.resetRecording()
                                self.isSaveClicked = false
                                self.isStopSelected = false
                            } label: {
                                Text("취소")
                                    .padding()
                                    .foregroundStyle(Color.text)
                                    .frame(width: 179, height: 92)
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle.bold())
                                    .background(
                                        RoundedRectangle(cornerRadius: 90)
                                            .fill(Color.white)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 90)
                                            .stroke(Color.black, lineWidth: 5)
                                    )
                                
                            }
                            
                            Spacer()
                                .frame(width: 69)
                            
                            
                            if isSaveClicked {
                                Button {
                                    guard let id = self.id else {
                                        return
                                    }
                                    
                                    guard let url = audioController.fileURL else {
                                        return
                                    }
                                    let date = Date()
                                    PersistentController.shared.saveLetter(id: id, date: date, url: url)
                                    
//                                    audioController.resetRecording()
                                    self.isSaveClicked = false
                                    self.isStopSelected = false

                                    
                                    print("Save Success")
                                } label: {
                                    Text("보내기")
                                        .padding()
                                        .foregroundStyle(Color.white)
                                        .frame(width: 179, height: 92)
                                        .dynamicTypeSize(.xxxLarge)
                                        .font(.largeTitle.bold())
                                        .background(
                                            RoundedRectangle(cornerRadius: 90)
                                                .fill(Color.prim)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 90)
                                                .stroke(Color.str, lineWidth: 5)
                                        )
                                }
                            }
                            else {
                                Button {
                                    isSaveClicked.toggle()
                                    self.isStopSelected = true
                                    self.isSaveClicked = true
                                    audioController.stopRecording()
                                } label: {
                                    Text("저장")
                                        .padding()
                                        .foregroundStyle(Color.text)
                                        .frame(width: 179, height: 92)
                                        .dynamicTypeSize(.xxxLarge)
                                        .font(.largeTitle.bold())
                                        .background(
                                            RoundedRectangle(cornerRadius: 90)
                                                .fill(Color.white)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 90)
                                                .stroke(Color.black, lineWidth: 5)
                                        )
                                    
                                }
                            }
                            
                            Spacer()
                                .frame(width: 101)
                            
                        }
                        .padding(.top, 90)
                        
                    }
                    
                }
                
                
                Spacer()
                    .frame(height: 65)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 32) {
                        // TODO: - 일정 순 제대로 나오지 않음 (수정 완료)
                        let filteredDiaries = diaries.filter { diary in
                            if diary.uploadDate != nil && Date() < diary.uploadDate! {
                                return false
                            }
                            return true
                        }
                        
                        ForEach(0..<filteredDiaries.count, id: \.self) { index in
                            ZStack{
                                if let data = filteredDiaries[index].image {
                                    GrandMotherPhotos(image: UIImage(data: data), date: filteredDiaries[index].savedDate, namespace: animationNameSpace, index: index)
                                        .frame(width: 502, height: 670)
                                        .aspectRatio(3/4, contentMode: .fit)
                                        .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 0)
                                        .overlay {
                                            if !filteredDiaries[index].isRead {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .frame(width: 502, height: 670)
                                                        .foregroundStyle(Color.white)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 20)
                                                                .strokeBorder(lineWidth: 5)
                                                        )
                                                    
                                                    VStack {
                                                        Text("엽서 왔어요!")
                                                            .dynamicTypeSize(.accessibility2)
                                                            .font(.largeTitle.bold())
                                                        Text("누르시면 엽서와 내용을\n볼 수 있습니다.")
                                                            .multilineTextAlignment(.center)
                                                            .dynamicTypeSize(.accessibility2)
                                                            .font(.headline.bold())
                                                            .foregroundStyle(Color(hex: "9C273C"))
                                                        Image(systemName: "envelope.fill")
                                                            .foregroundStyle(Color.prim)
                                                            .opacity(0.15)
                                                            .font(.system(size:320))
                                                            .frame(width: 382, height: 273)
                                                    }
                                                }
                                            }
                                        }
                                    
                                }
                                
                            }
                            .onTapGesture {
                                self.selectedDiary = filteredDiaries[index]
                                self.selectedIndex = index
                                withAnimation{
                                    showDetailView.toggle()
                                }
                                
                                filteredDiaries[index].isRead = true
                                
                                do {
                                    try PersistentController.shared.container.viewContext.save()
                                } catch {
                                    print("Failed")
                                }
                            }
                            
                            
                        }
                        
                    }
                    
                } //ScrollView
            }
            if showDetailView {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .edgesIgnoringSafeArea(.all)
                
                
                GrandMotherDetailView(showDetailView: $showDetailView, animationNamespace: animationNameSpace, diary: self.selectedDiary!, index: self.selectedIndex!)
                    .frame(width:1026, height: 912)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.text, lineWidth: 5)
                    )
            }
        }
        
        
    }
    
    func makeFaceTimeAudioCall(phoneNumber: String) {
        if let url = URL(string: "facetime-audio://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            print("Cannot make FaceTime audio call")
        }
    }
}



#Preview {
    GrandMotherMainView()
}
