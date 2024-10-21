//
//  ContentView.swift
//  McConaughey
//
//  Created by Aimee Hong on 10/21/24.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var stepperValue = 1
    @State private var audioPlayer: AVAudioPlayer!
    var body: some View {
        VStack {
            Text("How Is Matt?")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Image("matt")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 30)
            
            Spacer()
            
            Stepper("How Alright Is Matt?", value: $stepperValue, in: 1...10)
                .font(.title2)
            
            Text(String(stepperValue))
                .font(.largeTitle)
            
            Spacer()
            
            Button("Tell Me!") {
                playSound(soundName: "alright")
            }
            .buttonStyle(.bordered)
            .bold()
        }
        .padding()
    }
    
    func playSound(soundName: String) {
        if audioPlayer != nil {
            audioPlayer.stop()
        }
        
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 ERROR: Could not read file named \(soundName).")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.numberOfLoops = stepperValue - 1
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) when trying to create audioPlayer.")
        }
    }
}

#Preview {
    ContentView()
}
