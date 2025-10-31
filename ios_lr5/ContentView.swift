//
//  ContentView.swift
//  ios_lr5
//
//  Created by ІПЗ-31/1 on 30.10.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JokeViewModel()
    
    var body: some View {
        ZStack {
            Image("chuck")
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Chuck Norris Facts")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .heavy))
                        .italic()
                        .underline()
                        .background(.black.opacity(0.7))
                    
                    if viewModel.isLoading {
                        ProgressView("Завантаження...")
                    } else if let joke = viewModel.currentJoke {
                        Text(joke.value)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .heavy))
                            .background(.black.opacity(0.7))
                            .padding()
                            .multilineTextAlignment(.center)
                    } else if let error = viewModel.errorMessage {
                        Text("Помилка: \(error)")
                            .foregroundColor(.red)
                    } else {
                        Text("Натисни кнопку, щоб отримати факт!")
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        viewModel.loadJoke()
                    }) {
                        Text("Get a New Fact")
                            .padding()
                            .background(Color.green.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                }
            }
            .padding()
            .onAppear {
                viewModel.loadJoke()
            }
        }
    }
}

#Preview {
    ContentView()
}
