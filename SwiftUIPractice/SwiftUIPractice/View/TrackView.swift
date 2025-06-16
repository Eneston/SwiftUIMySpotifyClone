//
//  TrackView.swift
//  SwiftUIPractice

import SwiftUI

struct TrackView : View {
    let name : String
    let artist : String
    let explicit:  Bool
    let playing : Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
               Text(name)
                    .font(.system(size: 24))
                    .foregroundColor(playing ? Color.accentGreen : .white)
                
                HStack {
                    if explicit {
                        Image(systemName: "e.square.fill")
                    }
                    Text(artist)
                        .font(.system(size: 12))
                }
                .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "ellipsis")
        }
        .padding(.horizontal)
        .background(playing ? Color.green.opacity(0.3) : Color.clear)
        .onTapGesture {
            onTap()
        }
    }
}


struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView(
            name: "Politics As Usual",
            artist: "JAY-Z",
            explicit: true,
            playing: false,
            onTap: {
            // Preview’da sadece boş bırakılabilir.
            print("Preview: Track tapped")
          }
        )
    }
}
