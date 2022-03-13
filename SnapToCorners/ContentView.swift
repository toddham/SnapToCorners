//
//  ContentView.swift
//  SnapToCorners
//
//  Created by Todd Hamilton on 3/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var location:CGPoint = CGPoint(x:90, y:60)
    @GestureState var startLocation:CGPoint? = nil
    
    var body: some View {
        ZStack{
            Color(.systemGray6)
            GridView()
            GeometryReader{ geometry in
                Image("lasso")
                    .resizable()
                    .scaledToFill()
                    .frame(width:180,height:120)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .position(location)
                    .gesture(DragGesture()
                                .onChanged{value in
                        var newLocation = startLocation ?? location
                        newLocation.x += value.translation.width
                        newLocation.y += value.translation.height
                        location = newLocation
                    }
                                .updating($startLocation){value, startLocation, transaction in
                        startLocation = startLocation ?? location
                    }
                                .onEnded{value in
                        withAnimation(.interpolatingSpring(stiffness: 100, damping: 20, initialVelocity: 5)){
                            location = snapToLocation(screenSize: geometry.size, predictedLocation: value.predictedEndLocation)
                        }
                    }
                    )
            }
        }
    }
    func snapToLocation(screenSize:CGSize, predictedLocation:CGPoint) -> CGPoint {
        let hBreak = screenSize.width/2
        let vBreak = screenSize.height/2
        let endX = predictedLocation.x
        let endY = predictedLocation.y
        var endLocation:CGPoint = .zero
        if(endX < hBreak && endY < vBreak){
            endLocation = CGPoint(x:90, y:60)
        } else if(endX > hBreak && endY < vBreak){
            endLocation = CGPoint(x:screenSize.width - 90, y:60)
        } else if(endX < hBreak && endY > vBreak){
            endLocation = CGPoint(x:90, y:screenSize.height - 60)
        } else if (endX > hBreak && endY > vBreak){
            endLocation = CGPoint(x:screenSize.width - 90, y:screenSize.height - 60)
        }
        return endLocation
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
