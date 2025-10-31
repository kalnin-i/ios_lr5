//
//  Joke.swift
//  ios_lr5
//
//  Created by ІПЗ-31/1 on 31.10.2025.
//

import Foundation

struct Joke: Codable, Identifiable {
    let id: String
    let value: String
    let url: String
}
