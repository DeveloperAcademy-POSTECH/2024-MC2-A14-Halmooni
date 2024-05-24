import SwiftUI

struct AudioPlayerView: View {
    @StateObject private var audioPlayerViewModel = AudioPlayerViewModel()
    
    var body: some View {
        VStack {
            ProgressView(value: audioPlayerViewModel.currentTime, total: audioPlayerViewModel.duration)
                .progressViewStyle(LinearProgressViewStyle(tint: .prim))
                .padding(.horizontal, 233)
            
            
            HStack {
                Text(formatTime(audioPlayerViewModel.currentTime))
                    .padding(.leading, 220)
                Spacer()
                Text(formatTime(audioPlayerViewModel.duration))
                    .padding(.trailing, 220)
            }
            .padding(.horizontal)
            
            Button(action: {
                audioPlayerViewModel.playOrPause()
            }) {
                Image(systemName: audioPlayerViewModel.isPlaying ? "pause.fill" : "play.fill")
                    .font(.largeTitle)
                    .foregroundColor(.prim)
            }
        }
        .padding(40)
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView()
    }
}
