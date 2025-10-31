//
//  JokeService.swift
//  ios_lr5
//
//  Created by ІПЗ-31/1 on 31.10.2025.
//

import Foundation

class JokeService {
    private let baseURL = "https://api.chucknorris.io/jokes/random"
    
    func fetchRandomJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let joke = try JSONDecoder().decode(Joke.self, from: data)
                completion(.success(joke))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
