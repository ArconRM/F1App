//
//  F1AppTests.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 21.11.2024.
//

import XCTest
@testable import F1App

final class F1AppTests: XCTestCase {
    let networkManager = RacesNetworkManagerImpl(urlSource: F1ConnectUrlSource())
    
    func testExample() {
        let didReceiveResponse = expectation(description: #function)
        
        networkManager.fetchCurrentSeasonRaces(resultQueue: .main) { result in
            switch result {
            case .success(let races):
                for race in races {
                    print(String(describing: race))
                }
                XCTAssert(true)
            case .failure(let failure):
                print(failure)
                XCTAssert(false)
            }
            didReceiveResponse.fulfill()
        }
        wait(for: [didReceiveResponse], timeout: 10)
    }

}
