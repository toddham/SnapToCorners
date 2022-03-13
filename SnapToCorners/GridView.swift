//
//  GridView.swift
//  SnapToCorners
//
//  Created by Todd Hamilton on 3/13/22.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(width:1, height:UIScreen.main.bounds.height/2)
                
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(width:UIScreen.main.bounds.width/2, height:1)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
