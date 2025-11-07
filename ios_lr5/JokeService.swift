//
//  JokeService.swift
//  ios_lr5
//
//  Created by ІПЗ-31/1 on 31.10.2025.
//

import Foundation
import SystemConfiguration

class JokeService {
    private let baseURL = "https://api.chucknorris.io/jokes/random"
    
    func fetchRandomJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
        guard isConnectedToNetwork() else {
            completion(.failure(URLError(.notConnectedToInternet)))
            return
        }
        
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
    
    private func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)

            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }) else { return false }

            var flags: SCNetworkReachabilityFlags = []
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }

            return flags.contains(.reachable) && !flags.contains(.connectionRequired)
        }
}
