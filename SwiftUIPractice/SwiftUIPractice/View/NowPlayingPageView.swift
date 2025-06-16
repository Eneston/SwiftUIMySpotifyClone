//
//  NowPlayingPageView.swift
//  SwiftUIPractice

import SwiftUI

struct NowPlayingPageView: View {
    let song : Song
    var onDismiss : () -> Void
    
    var body: some View {
        
        VStack() {
            // TopNavBar Icon
            HeaderControls(onDismiss: onDismiss,song: song)
            Spacer()
            //Albüm kapağı
            NowPlayingImage(song: song)
            //Sanatçı parça adı
            ArtistandTrackName(song: song)
            // Oynatma Kontrolleri
            PlayBackController()
            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .foregroundColor(.white)
        
    }
}

struct NowPlayingPageView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingPageView(song: .mock,onDismiss: {})
    }
}

/// MediaPlayerController
struct PlayBackController : View {
    
    let imageBackIcon : String = "backward.fill"
    let imageForwardIcon : String = "forward.fill"
    let imagePlayCircleIcon : String = "play.circle.fill"
    
    var body: some View {
        HStack(spacing: 40 ) {
            Image(systemName: imageBackIcon)
            .font(.title)

            Image(systemName: imagePlayCircleIcon)
            .font(.system(size: 60))

            Image(systemName: imageForwardIcon)
            .font(.title)
        }
        .padding(.top,30)
    }
}

/// Parça Adı ve Sanatçı Adı
struct ArtistandTrackName : View {
    let song: Song
    
    var body: some View {
        VStack(spacing: 4 ) {
            Text(song.title)
                .font(.title2)
                .bold()
            Text(song.artist)
            .font(.subheadline)
            .foregroundColor(.gray)
        }
    }
}

/// TopNavBar
struct HeaderControls : View {
    
    let onDismiss : () -> Void
    let song : Song
    
    @State private var showOptions = false
    
    let imageChevronIcon : String = "chevron.down"
    let imageEllipsisIcon : String = "ellipsis"
    
    var body: some View {
        HStack {
            Button(action: {
                onDismiss()
            }) {
                Image(systemName: imageChevronIcon)
                    .font(.title2)
                    .padding()
            }
            Spacer()
            
            Button(action: {
               showOptions = true
            }) {
                Image(systemName: imageEllipsisIcon)
                .rotationEffect(.degrees(90))
                .font(.title2)
                .padding()
                }
            .fullScreenCover(
                isPresented: $showOptions,
                content: {
                OptionsView(song: song)
            })
        }
    }
}

/// Ellipsis (3 nokta) ikona basıldığında diğer sayfayı gösteriyor.
struct OptionsView: View {
    let song : Song
    var body: some View {

        VStack {
            /// Kapama Buton
            CloseButton()
            /// Albüm
            NowPlayingImage(song: song)
            /// Albüm Adı ve sanatçı adı
            ArtistandTrackName(song: song)
        
            
            // Seçenekler
            VStack(spacing: 16) {
            OptionButton(icon: "heart", title: "Beğen")
            OptionButton(icon: "plus", title: "Çalma Listesine Ekle")
            OptionButton(icon: "square.and.arrow.up", title: "Paylaş")
            OptionButton(icon: "info.circle", title: "Şarkı Bilgisi")
            }
            .padding(.top, 30)
            
            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundColor(.white)
    }
}

/// Custom Albüm Resmi
struct NowPlayingImage : View {
    let song : Song
    
    var body: some View {
        Image(song.imageUrl)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .cornerRadius(20)
    }
}


// Yardımcı component - Seçenek Butonları
struct OptionButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 30)
            
            Text(title)
                .font(.body)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

/// CloseButton
struct CloseButton : View {
    /// Dismiss için env oluşturdum.
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            Button("Kapat") {
                presentationMode.wrappedValue.dismiss()

            }
            // Butonu köşeye ittim
            Spacer()
        }
        .padding()
    }
}
