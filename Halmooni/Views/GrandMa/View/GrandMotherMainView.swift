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
    @State private var gifClicked = UserDefaults.standard.gifClicked
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
    
    
    @FetchRequest(entity: Diary.entity(), sortDescriptors: [.init(keyPath: \Diary.savedDate, ascending: true)])
    var diaries:FetchedResults<Diary>
    
    @State var selectedDiary: Diary?
    
    var body: some View {
        
        ZStack {
            

            
            Color.bg.ignoresSafeArea()
            
            imageColorScheme

            VStack {
                    
                    // TODO: 전화 연결 클라우드 사용 방안으로 변경
                    Button(action: {
                        makeFaceTimeCall(phoneNumber: phoneNumber)
                    }) {
//                        let telephone = "tel://"
//                        let formattedString = telephone + numberString
//                        guard let url = URL(string: formattedString) else { return }
//                        UIApplication.shared.open(url)
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(.section)
                                .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 2)
                            
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
                        .frame(width: 502, height: 92)
                        
                    }
                    .padding(.top, 90)
                    .padding(.trailing, 140)
                    .padding(.leading, 750)
                
                Spacer()
                    .frame(height: 65)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 32) {
                        
                        ForEach(diaries){ diary in
                            ZStack{
                                if let data = diary.image {
                                    GrandMotherPhotos(image: UIImage(data: data), date: diary.savedDate)
                                        .frame(width: 502, height: 670)
                                        .aspectRatio(3/4, contentMode: .fit)
                                        .shadow(color:Color.black.opacity(0.15), radius: 15, x: 0, y: 0)
                                        .overlay {
                                            if !diary.isRead {
                                                GifView(gifName: "NewMessage")
                                                    .frame(width: 502, height: 670)
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                            }
                                        }
                                    
                                }

                            }
                            .onTapGesture {
                                self.selectedDiary = diary
                                withAnimation{
                                    showDetailView.toggle()
                                }
                                
                                diary.isRead = true
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
                
                
                GrandMotherDetailView(showDetailView: $showDetailView, animationNamespace: animationNameSpace, diary: self.selectedDiary!)
                    .frame(width:1026, height: 912)
                    .cornerRadius(20)
            }
        }
        
        
    }
    func makeFaceTimeCall(phoneNumber: String) {
        let faceTimeURLString = "facetime://\(phoneNumber)"
        if let faceTimeURL = URL(string: faceTimeURLString) {
            if UIApplication.shared.canOpenURL(faceTimeURL) {
                UIApplication.shared.open(faceTimeURL, options: [:], completionHandler: nil)
            } else {
                print("FaceTime을 열 수 없습니다.")
            }
        }
    }
}



#Preview {
    GrandMotherMainView()
}
