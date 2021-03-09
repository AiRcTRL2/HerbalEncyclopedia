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
    /// - Parameter fileName: the file name to be parsed
    /// - Returns: An optional of type T, where T is the expected model when successful parsing occurs.
    static func parseJson<T: Decodable>(_ fileName: String) -> T? {
        if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let fileData = try Data(contentsOf: file)
                return try decoder.decode(T.self, from: fileData)
            } catch (let parsingError) {
                print("A problem occurred when trying to parse the data from a file.")
                print(parsingError)
            }
        }
        
        return nil
    }
}
