//
//  ContentView.swift
//  ios_lr5
//
//  Created by ІПЗ-31/1 on 30.10.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JokeViewModel()
    @StateObject private var settingsVM = SettingsViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel()

    var buttonColor: Color {
        switch settingsVM.settings.buttonColor {
        case "red": return .red
        case "blue": return .blue
        default: return .green
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
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
                                .font(.system(size: settingsVM.settings.fontSize, weight: .medium))
                                .padding()
                                .background(.black.opacity(0.6))
                                .cornerRadius(12)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }

                        else {
                            Text("Press the button to get a new fact!")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.system(size: settingsVM.settings.fontSize))
                                .padding()
                                .background(.black.opacity(0.6))
                                .cornerRadius(8)
                        }

                        Button(action: {
                            viewModel.loadJoke()
                        }) {
                            Text("Get a New Fact")
                                .padding()
                                .font(.system(size: settingsVM.settings.fontSize, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .background(buttonColor.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }

                        if let fact = viewModel.currentJoke?.value {
                            Button(action: {
                                favoritesVM.addFact(fact)
                            }) {
                                Text("Save Fact")
                                    .padding()
                                    .font(.system(size: settingsVM.settings.fontSize, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    .background(buttonColor.opacity(0.8))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
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
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink("Saved") {
                        FavoritesView(favoritesVM: favoritesVM)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Settings") {
                        SettingsView(settingsVM: settingsVM)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
