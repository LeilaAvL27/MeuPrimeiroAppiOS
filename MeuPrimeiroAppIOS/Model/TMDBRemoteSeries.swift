//
//  TMDBRemoteMovies.swift
//  MeuPrimeiroAppiOS
//
//  Created by Yago Marques on 01/08/23.
//

import Foundation

struct TMDBRemoteMovies: Decodable {
    let results: [Movie]
}
