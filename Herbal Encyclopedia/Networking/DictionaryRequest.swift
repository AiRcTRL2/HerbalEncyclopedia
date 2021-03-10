//
//  DictionaryRequest.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 10/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

protocol DictionaryRequestProtocol {
    func fetchDictionary(url: String) -> [String: String]?
}

class DictionaryRequest: Request, DictionaryRequestProtocol {
    func fetchDictionary(url: String) -> [String : String]? {
        configure(requestType: .file, urlOrFileName: url)
        
        let data = request()
        guard data != nil, let dictionaryContainer: DictionaryContainer? = ModelParser.parseJson(data!) else {
            print("Failed to parse dictionary from data for url: \(url)")
            return nil
        }
        
        return dictionaryContainer?.data
    }
    
    
}
