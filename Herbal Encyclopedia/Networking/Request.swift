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
    
    func request<T: Decodable>() -> T? {
        switch isFileOrNetworkingRequest {
        case .file:
            return fileRequest()
        case .network:
            return networkRequest()
        }
    }
    
    private func networkRequest<T: Decodable>() -> T? {
        nil
    }
    
    private func fileRequest<T: Decodable>() -> T? {
        ModelParser.parseJson(url)
    }
}
