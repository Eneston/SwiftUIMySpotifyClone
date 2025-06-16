//  LibraryPageView.swift
//  SwiftUIPractice


import Foundation
import SwiftUI


struct LibraryPageView: View {
    @ObservedObject var viewModel: SongViewModel
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Kitaplığım")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                // Recently Played Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Son Çalınanlar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.songs.prefix(10), id: \.id) { song in
                                LibrarySongRow(song: song) {
                                    viewModel.playSong(song)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer(minLength: 100) // Space for media player
            }
            .padding(.top)
        }
        .foregroundColor(.white)
    }
}

// MARK: - Library Song Row
struct LibrarySongRow: View {
    let song: Song
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: song.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(song.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(song.artist)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(90))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
