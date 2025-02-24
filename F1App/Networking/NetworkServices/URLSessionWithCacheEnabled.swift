//
//  URLSessionWithCacheEnabled.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 23.02.2025.
//

import Foundation

class URLSessionWithCacheEnabled {
    static var shared = URLSessionWithCacheEnabled()

    let session: URLSession

    private init() {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.requestCachePolicy = .useProtocolCachePolicy
        session = URLSession(configuration: config)
    }
}
