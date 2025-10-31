//
//  JokeViewModel.swift
//  ios_lr5
//
//  Created by ІПЗ-31/1 on 31.10.2025.
//

import Foundation


@MainActor
class JokeViewModel: ObservableObject {
    @Published var currentJoke: Joke?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = JokeService()
    
    func loadJoke() {
        isLoading = true
        errorMessage = nil
        
        service.fetchRandomJoke { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let joke):
                    self?.currentJoke = joke
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
