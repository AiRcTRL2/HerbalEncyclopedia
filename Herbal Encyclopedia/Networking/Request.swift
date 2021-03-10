//
//  Request.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 09/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

enum FileOrNetworkRequest {
    case file
    case network
}

/// This will be the class that handles any API interaction (root).
/// It shall hold request configuration params/methods, carry out the request, return data when finished
class Request {
    private var isFileOrNetworkingRequest: FileOrNetworkRequest = .file
    private var url: String = ""
    // TODO: Add AlamoFire properties
    
    func configure(requestType: FileOrNetworkRequest, urlOrFileName: String) {
        self.isFileOrNetworkingRequest = requestType
        self.url = urlOrFileName
    }
    
    func request() -> Data? {
        switch isFileOrNetworkingRequest {
        case .file:
            return fileRequest()
        case .network:
            return networkRequest()
        }
    }
    
    private func networkRequest() -> Data? {
        nil
    }
    
    private func fileRequest() -> Data? {
        if let file = Bundle.main.url(forResource: url, withExtension: "json") {
            do {
                return try Data(contentsOf: file, options: .mappedIfSafe)
            } catch (let err) {
                print("Error fetching the data resource from file \(url)")
                print(err)
            }
        }
        
        return nil
    }
}
