import SwiftUI
import UIKit


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
    @Namespace private var animationNameSpace
    
    
    let numberString = "111-222-3333"
    
    let columns: [GridItem] = [
        GridItem(.fixed(592), spacing: 62),
        GridItem(.fixed(592), spacing: 62)
    ]
    
    
    var body: some View {
        
        ZStack {
            Color.bg.ignoresSafeArea()
            
            VStack {
                HStack {
                    ZStack {
                        Image("GrandmaDate")
                            .resizable()
                            .padding(.leading, 60)
                            .padding(.top, 11)
                            .frame(width: 297, height: 145)
                        HStack(alignment: .top) {
                            Text("2024")
                                .dynamicTypeSize(.accessibility1)
                                .font(.title)
                                .bold()
                                .padding(.leading, 50)
                                .padding(.trailing, 10)
                            Text("5月")
                                .bold()
                                .dynamicTypeSize(.accessibility4)
                                .font(.largeTitle)
                        }
                    }

                    
                    
                    Button {
                            let telephone = "tel://"
                            let formattedString = telephone + numberString
                            guard let url = URL(string: formattedString) else { return }
                            UIApplication.shared.open(url)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(.white)
                                .shadow(radius: 5)
                                .frame(width: 592, height: 100)
                            
                            HStack {
                                
                                Text("인범이에게 전화하기")
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                                    .bold()
                                    .padding(.leading, 46)
                                
                                Spacer()
                                
                                Image(systemName: "phone.circle.fill")
                                    .foregroundColor(.green)
                                    .dynamicTypeSize(.xxxLarge)
                                    .font(.largeTitle)
                                    .padding(.trailing, 33)
                            }
                            .padding()
                        }
                        .padding(.trailing, 60)
                        .padding(.leading, 370)
                    }
                    .padding(.top, 65)
                }
                Spacer()
                    .frame(height: 65)
                
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                        ForEach(0..<2) { i in
                            ZStack {
                                if !showDetailView {
                                    VStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.blue) // 색상 추가 (선택 사항)
                                            .frame(width: 592, height: 692)
                                            .matchedGeometryEffect(id: "photo\(i)", in: animationNameSpace)
                                            .onTapGesture {
                                                withAnimation(.spring()) {
                                                    showDetailView.toggle()
                                                }
                                            }
                                    }
                                }
                                
                                

                                
                                if !self.select {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                    Image(systemName: "photo.artframe")
                                        .font(.largeTitle)
                                }
                                
                            }
                            .onTapGesture {
                                withAnimation{
                                    showDetailView.toggle()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 60)
                }
            }
            if showDetailView {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .edgesIgnoringSafeArea(.all)
                
                GrandMotherDetailView(showDetailView: $showDetailView, animationNamespace: animationNameSpace)
                    .transition(.opacity)
                //detailview 임의 설정
                    .frame(width:1026, height: 904)
                    .background(Color.white)
                    .cornerRadius(20)
                    
            }
        }
    }
}



#Preview {
    GrandMotherMainView()
}
