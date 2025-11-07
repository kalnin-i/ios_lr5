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
            // 🔹 Фон
            Image("chuck")
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Chuck Norris Facts")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .heavy))
                        .italic()
                        .underline()
                        .padding(.top)
                        .background(.black.opacity(0.6))
                        .cornerRadius(8)
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .tint(.white)
                            .padding()
                    }
                    else if let joke = viewModel.currentJoke {
                        Text(joke.value)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                            .padding()
                            .background(.black.opacity(0.6))
                            .cornerRadius(12)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    else {
                        Text("Press the button to get a new fact!")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 18))
                            .padding()
                            .background(.black.opacity(0.6))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        viewModel.loadJoke()
                    }) {
                        Text("Get a New Fact")
                            .padding()
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical, 20)
            }
            .onAppear {
                viewModel.loadJoke()
            }
        }
    }
}

#Preview {
    ContentView()
}
