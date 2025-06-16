//
//  MediaPlayerView.swift
//  SwiftUIPractice

import SwiftUI


struct MediaPlayerView: View {
    
    @ObservedObject var viewModel: MediaPlayerViewModel
    
    let title: String
    let subtitle: String
    let imageTitle: String
    var width: CGFloat = 60
    var heigt: CGFloat = 60
    var textSize: CGFloat = 14
    var imageTextSize: CGFloat = 25
    let onTap: (() -> Void)?
    
    var body: some View {
        HStack {
            Button(action: {
                onTap?()
            }) {
                HStack {
                    Image(imageTitle)
                        .resizable()
                        .frame(width: width, height: heigt)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .foregroundColor(.gray)
                        Text(subtitle)
                            .foregroundColor(.gray)
                    }
                    .font(.system(size: textSize))
                    
                    Spacer()
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            HStack(spacing: 35) {
                Image(systemName: "hifispeaker")
                    .foregroundColor(.gray)
                
                Button(action: {
                    viewModel.togglePlayPause()
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                }
            }
            .font(.system(size: imageTextSize))
            .padding(.trailing)
        }
        .border(Color.black, width: 0.3)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.primaryBackground)
        .cornerRadius(12)
    }
}


struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayerView(
            viewModel: MockMediaPlayerViewModel(isPlaying: false),
            title: "Introverted",
            subtitle: "Elzhi",
            imageTitle: "Jay",
            onTap: { print("Tapped") } // Örnek aksiyon
        )
    }
}

class MockMediaPlayerViewModel: MediaPlayerViewModel {
    init(isPlaying: Bool = false) {
        super.init(urlString: "")
        self.isPlaying = isPlaying
    }
}
