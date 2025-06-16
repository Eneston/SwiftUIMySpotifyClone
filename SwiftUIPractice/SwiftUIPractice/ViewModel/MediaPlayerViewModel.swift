//
//  MediaPlayerViewModel.swift
//  SwiftUIPractice


import Foundation
import AVFoundation
import Combine


class MediaPlayerViewModel : ObservableObject {
    @Published var isPlaying: Bool = false
    private var player: AVPlayer?
    
    
    init(urlString: String) {
           if let url = URL(string: urlString) {
               self.player = AVPlayer(url: url)
           }
       }
    
    func togglePlayPause() {
        guard let player = player else {return}
        if isPlaying  {
            player.pause()
        }else {
            player.play()
        }
        isPlaying.toggle()
    }
    
}
