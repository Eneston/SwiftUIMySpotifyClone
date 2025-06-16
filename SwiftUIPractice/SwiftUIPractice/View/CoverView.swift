//
//  CoverView.swift
//  SwiftUIPractice
import SwiftUI


struct CoverView : View {
    
    let imageName : String
    var iconName : String
    
    var body: some View {
        ZStack(alignment: .top) {
        Image(imageName)
            .resizable()
            .frame(width: 220, height: 220)
            .shadow(radius: 5)
            Image(systemName: iconName)
                .offset(x:-165)
                .font(.system(size: 20))
            
      }
    }
}



struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView(imageName: "Jay", iconName: "chevron.left")
    }
}


