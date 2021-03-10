//
//  ModelParser.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

struct ModelParser {
    /// Parses a local json file into an expected model
    /// - Parameter data: File data received from a network or local file request
    /// - Returns: An optional of type T, where T is the expected model when successful parsing occurs.
    static func parseJson<T: Decodable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch (let parsingError) {
            print("A problem occurred when trying to parse the data from a file.")
            print(parsingError)
        }
        
        return nil
    }
}
