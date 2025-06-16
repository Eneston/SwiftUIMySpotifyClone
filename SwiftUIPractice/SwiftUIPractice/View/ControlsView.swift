import SwiftUI

struct ControlsView: View {
    let album: String
    let albumYear: String
    var albumFontSize: CGFloat = 14
    let onShufflePlay: () -> Void 

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(album)
                        .font(.system(size: albumFontSize, weight: .bold))
                    CustomCircle()
                    Text(albumYear)
                }

                AllIcon()
                    .font(.system(size: 25))
            }
            .foregroundColor(.gray)
            .font(.system(size: 14))

            Spacer()

            //  Shuffle Play Butonu
            Button(action: {
                onShufflePlay()
            }) {
                ZStack {
                    CustomCircle(width: 60, height: 60, foregroundColor: .accentGreen)
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(album: "Albüm", albumYear: "1996", onShufflePlay: {})
    }
}

struct AllIcon: View {
    let heart: String = "heart"
    let arrowDownCircle: String = "arrow.down.circle"
    let ellipsis: String = "ellipsis"
    var spacing: CGFloat = 25

    var body: some View {
        HStack(spacing: spacing) {
            Image(systemName: heart)
            Image(systemName: arrowDownCircle)
            Image(systemName: ellipsis)
        }
    }
}

struct CustomCircle: View {
    var width: CGFloat = 3
    var height: CGFloat = 3
    var foregroundColor: Color?

    var body: some View {
        Circle()
            .frame(width: width, height: height)
            .foregroundColor(foregroundColor)
    }
}
