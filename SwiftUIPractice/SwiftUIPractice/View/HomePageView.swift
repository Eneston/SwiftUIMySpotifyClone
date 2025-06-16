//
//  HomePageView.swift
//  SwiftUIPractice


import Foundation
import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel: SongViewModel
    @Binding var selectedSong: Song?
    @Binding var showNowPlaying: Bool
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                /// Albümün Kapak Fotoğrafı
                CoverView(imageName: "Jay", iconName: "chevron.left")
                VStack {
                    /// Sanatçının Adı ve Fotoğrafı
                    ArtistInfo(title: "Reasonable Doubt", imageTitle: "profilePic", articleName: "JAY-Z")
                   
                    /// Albüm adı ve çıkış yılı
                    ControlsView(
                        album: "Albüm",
                        albumYear: "1996",
                        onShufflePlay: {
                            viewModel.shuffleSongs()
                        }
                    )
                    
                    /// Mix & Parçalar. Tıklandığında hangi parçada olduğunu gösterir.
                    TrackListView(viewModel: viewModel)
                }
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

