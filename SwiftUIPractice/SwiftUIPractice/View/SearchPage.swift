import SwiftUI

struct SearchPageView: View {
    @ObservedObject var viewModel: SongViewModel
    @State private var searchText: String = ""
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                
                // Arama Alanı
                CustomSearchBar(searchText: $searchText, isSearchFocused: $isSearchFocused)

                // Şarkı listesi
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.songs.filter {
                            searchText.isEmpty || $0.title.lowercased().contains(searchText.lowercased())
                        }) { song in
                            SongRowView(song: song) {
                                viewModel.playSong(song)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 100) // Space for media player
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isSearchFocused = true
            }
        }
        .foregroundColor(.white)
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView(viewModel: SongViewModel())
    }
}

struct CustomSearchBar: View {
    @Binding var searchText: String
    @FocusState.Binding var isSearchFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
            
            ZStack(alignment: .leading) {
                if searchText.isEmpty {
                    Text("Ne dinlemek istiyorsun?")
                        .foregroundColor(.white.opacity(0.5))
                }
                
                TextField("", text: $searchText)
                    .focused($isSearchFocused)
                    .textInputAutocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
            }

            if !searchText.isEmpty {
                Button("İptal") {
                    searchText = ""
                    isSearchFocused = false
                }
                .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}


struct SongRowView: View {
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
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(song.title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(song.artist)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image(systemName: "play.circle")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
