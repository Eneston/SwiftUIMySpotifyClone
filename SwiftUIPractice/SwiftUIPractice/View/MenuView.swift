//
//  MenuView.swift
//  SwiftUIPractice

import SwiftUI
struct MenuView : View {
    
    var body: some View {
        
        HStack {
            VStack(spacing: 8 ) {
                Image(systemName: "house")
                    .font(.system(size: 20))
                
                Text("Home")
                    .font(.system(size:12))
            }
            .foregroundColor(.gray)
            
            Spacer()
            
            VStack(spacing: 8 ) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                
                Text("Search")
                    .font(.system(size:12))
            }
            .foregroundColor(.gray)
            
            Spacer()

            VStack(spacing: 8 ) {
                Image(systemName: "text.justifyright")
                    .rotationEffect(.degrees(90))
                    .font(.system(size: 20))
                
                Text("Your Library")
                    .font(.system(size:12))
            }
            .foregroundColor(.gray)
        }
        .padding(.bottom,30)
        .padding(.top,2)
        .padding(.horizontal,40)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
