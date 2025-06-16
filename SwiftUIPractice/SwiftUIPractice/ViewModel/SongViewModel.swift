//
//  SongViewModel.swift
//  SwiftUIPractice


import Foundation
import Combine

class SongViewModel : ObservableObject {
    @Published var songs : [Song] = []
    @Published var currentlyPlaying: Song?
    @Published var isPlaying: Bool = false
    
    
    let mockSongs: [Song] = [
        Song(id: "1", title: "Elzhi", artist: "DJ Khaled", imageUrl: "https://i.scdn.co/image/ab6761610000e5ebf8b193e533dc4255db612f40", audioUrl: "",overlay: ""),
        Song(id: "2", title: "Lil Baby", artist: "Joey Bada", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhH6oONhvg0Qn2qM37GbTrhhb6AEdFJE0HXA&s", audioUrl: "",overlay: ""),
        Song(id: "3", title: "Reasonable Doubt", artist: "JAY-Z", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/f/f5/Reasonable_Doubt_New.jpg/250px-Reasonable_Doubt_New.jpg", audioUrl: "",overlay: "")

    ]
    
    init() {
        self.songs = mockSongs
    }
    
    func togglePlayPause() {
            isPlaying.toggle()
            // AudioManager ile senkronize etmek için
            if isPlaying {
                if let currentSong = currentlyPlaying {
                    AudioManager.shared.play(urlString: currentSong.audioUrl)
                }
            } else {
                AudioManager.shared.pause()
            }
        }



    
    /// Parçaları karışık halde çalar.
    func shuffleSongs() {
        guard let randomSong = songs.randomElement() else {return}
        AudioManager.shared.play(urlString: randomSong.audioUrl)
    }
    
    // Gelecekte Firebase'den verileri çektiğinde burada doldurucaz.
    // Mock Data Songs.
    func fetchSongsMock() {
        self.songs = [
            Song(id: "1", title: "Empire State Of Mind", artist: "JAY-Z", imageUrl: "Jay", audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",overlay: ""),
            Song(id: "2", title: "Young Forever", artist: "JAY-Z", imageUrl: "Jay", audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",overlay: ""),
        ]
    }
    
    /// Hangi şarkının çalındığını gösterir.
    func playSong(_ song: Song) {
        currentlyPlaying = song
        isPlaying = true
        AudioManager.shared.play(urlString: song.audioUrl)
    }
    
    

}


