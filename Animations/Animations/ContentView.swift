//
//  ContentView.swift
//  Animations
//
//  Created by Shilpa Seetharam on 05/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
           VStack {
               Button("Tap Me") {
                   withAnimation {
                       animationAmount += 1
                   }
               }
               .padding(40)
               .background(.red)
               .foregroundStyle(.white)
               .clipShape(Circle())
               .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
