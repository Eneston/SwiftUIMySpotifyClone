import SwiftUI

// MARK: - Main Content View (Renamed from ContentView)
struct MainContentView: View {
    @StateObject var viewModel = SongViewModel()
    @State private var selectedSong: Song? = nil
    @State private var showNowPlaying = false
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                // Home Tab
                HomePageView(
                    viewModel: viewModel,
                    selectedSong: $selectedSong,
                    showNowPlaying: $showNowPlaying
                )
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Ana Sayfa")
                }
                .tag(0)
                
                // Search Tab
                SearchPageView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "magnifyingglass.circle.fill" : "magnifyingglass")
                    Text("Ara")
                }
                .tag(1)
                
                // Library Tab
                LibraryPageView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "books.vertical.fill" : "books.vertical")
                    Text("Kitaplığım")
                }
                .tag(2)
            }
            .accentColor(.green)
            .background(Color.primaryBackground)
            .onAppear {
                            // Tab bar rengini ayarla
                            let appearance = UITabBarAppearance()
                            appearance.configureWithOpaqueBackground()
                            appearance.backgroundColor = UIColor(Color.primaryBackground)
                            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemGreen
                            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
                            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
                            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
                            
                            UITabBar.appearance().standardAppearance = appearance
                            UITabBar.appearance().scrollEdgeAppearance = appearance
                        }
            
            // Global Media Player - Always visible at bottom
            VStack {
                Spacer()
                if viewModel.currentlyPlaying != nil {
                    GlobalMediaPlayer(
                        viewModel: viewModel,
                        selectedSong: $selectedSong,
                        showNowPlaying: $showNowPlaying
                    )
                    .padding(.bottom,90) // TabView için yer 
                }
            }
        }
        .onAppear {
            viewModel.fetchSongsMock()
        }
    }
}


struct Background: View {
    var body: some View {
        // Renk dğeiştirisem tekrar paleti düzenelyecem şimdilik böyle kalsın.
        LinearGradient(
            colors: [
                Color.primaryBackground,
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

struct GlobalMediaPlayer: View {
    @ObservedObject var viewModel: SongViewModel
    @Binding var selectedSong: Song?
    @Binding var showNowPlaying: Bool
    
    var body: some View {
        VStack {
            MediaPlayerView(
                viewModel: MediaPlayerViewModel(urlString: viewModel.currentlyPlaying?.audioUrl ?? ""),
                title: viewModel.currentlyPlaying?.title ?? "",
                subtitle: viewModel.currentlyPlaying?.artist ?? "",
                imageTitle: viewModel.currentlyPlaying?.imageUrl ?? "",
                onTap: {
                    if let currentSong = viewModel.currentlyPlaying {
                        selectedSong = currentSong
                        showNowPlaying = true
                    }
                }
            )
            .fullScreenCover(isPresented: $showNowPlaying) {
                let songToShow = selectedSong ?? viewModel.currentlyPlaying ?? Song.mock
                NowPlayingPageView(song: songToShow) {
                    showNowPlaying = false
                }
            }
        }
        .background(Color.primaryBackground)
    }
}

struct TrackListView: View {
    
    @ObservedObject var viewModel: SongViewModel
    
    var body: some View {
        /// Mix & Parçalar. Tıklandığında hangi parçada olduğunu gösterir.
        VStack(spacing: 24) {
            ForEach(viewModel.songs) { song in
                TrackView(
                    name: song.title,
                    artist: song.artist,
                    explicit: true,
                    playing: viewModel.currentlyPlaying?.id == song.id,
                    onTap: {
                        viewModel.playSong(song)
                    }
                )
            }
        }
        .padding(.top)
    }
}
