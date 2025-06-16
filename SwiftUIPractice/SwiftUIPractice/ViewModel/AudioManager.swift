//
//  AudioManager.swift
//  SwiftUIPractice


import Foundation
import AVFoundation

class AudioManager {
    
    static let shared = AudioManager()
    private var player : AVPlayer?
    
    
    ///  Play tuşuna basıldığında parça başlar.
    func play(urlString : String) {
        guard let url = URL(string: urlString) else {return}
        player = AVPlayer(url: url)
        player?.play()
    }
    
    ///  Pause tuşuna basıldığında parça durur.
    func pause() {
        player?.pause()
    }
}
