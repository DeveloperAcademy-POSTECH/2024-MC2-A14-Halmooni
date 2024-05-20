import SwiftUI

struct AudioPlayerView: View {
    @StateObject private var audioPlayerViewModel = AudioPlayerViewModel()
    
    var body: some View {
        VStack {
            ProgressView(value: audioPlayerViewModel.currentTime, total: audioPlayerViewModel.duration)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .padding()
            
            HStack {
                Text(formatTime(audioPlayerViewModel.currentTime))
                Spacer()
                Text(formatTime(audioPlayerViewModel.duration))
            }
            .padding(.horizontal)
            
            Button(action: {
                audioPlayerViewModel.playOrPause()
            }) {
                Image(systemName: audioPlayerViewModel.isPlaying ? "pause.fill" : "play.fill")
                    .font(.largeTitle)
                    .foregroundColor(.prim)
            }
            .padding()
        }
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
