//
//  ContentView.swift
//  Flashlight
//
//  Created by Anant Parikh on 8/24/26.
//

import SwiftUI

struct BlackWhiteToggleStyle: ToggleStyle {
    var isLightOn: Bool     // Pass the state into the style so it knows the current screen mode

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Capsule()
                .fill(isLightOn ? Color.black : Color.white) // Screen White -> Toggle is Black. Screen Black -> Toggle is White.
                .frame(width: 51, height: 31)
                .overlay(
                    Capsule()
                        .stroke(Color.black, lineWidth: isLightOn ? 0 : 1)
                )
                .overlay(
                    Circle() // The moving thumb knob color
                        .fill(isLightOn ? Color.white : Color.black) // Screen White -> Knob is White. Screen Black -> Knob is Black.
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10) // Slides right when on, left when off
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.75)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct ContentView: View {
    @State private var lightOn = false
    var body: some View {
        ZStack {
            Color(lightOn ? .white : .black) // Background color that changes
                .ignoresSafeArea()
            
            VStack {
                Text("Flashlight")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .blendMode(.difference)
                
                Spacer()

                Toggle("", isOn: $lightOn)
                    .labelsHidden()
                    .padding()
                    .toggleStyle(BlackWhiteToggleStyle(isLightOn: lightOn)) // Pass the current state to the custom toggle style

            }
        }
        
        .animation(.default, value: lightOn) // Animate the background transition smoothly
    }
}

#Preview {
    ContentView()
}
