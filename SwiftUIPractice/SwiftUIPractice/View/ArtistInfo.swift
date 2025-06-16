//
//  ArtistInfo.swift
//  SwiftUIPractice

import SwiftUI

struct ArtistInfo : View {
    
    let title : String
    let imageTitle : String
    let articleName : String
    var titleSize : CGFloat = 25
    var imageWidth : CGFloat = 25
    var imageHeight : CGFloat = 25
    var articleNameSize : CGFloat = 14
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Reasonable Doubt
                Text(title)
                    .font(.system(size: titleSize, weight: .bold))
                HStack {
                    //profilePic
                    Image(imageTitle)
                        .resizable()
                        .frame(width: imageWidth, height: imageHeight)
                        .clipShape(Circle())
                    // JAY-Z
                    Text(articleName)
                        .font(.system(size: articleNameSize, weight: .bold))
                }
            }
            .padding(.leading)
            .padding(.top)
            Spacer()
        }
    }
}

struct ArtistInfo_Previews: PreviewProvider {
    static var previews: some View {
        ArtistInfo(title: "Reasonable Doubt", imageTitle: "profilePic", articleName: "JAY-Z")
    }
}


