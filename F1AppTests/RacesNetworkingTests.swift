//
//  RacesNetworkingTests.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 26.11.2024.
//

import XCTest
@testable import F1App

final class RacesNetworkingTests: XCTestCase {
    let raceDecoder = F1ConnectRaceDecoder()
    let networkManager = RacesNetworkServiceImpl(urlSource: UrlSourceF1Connect(), raceDecoder: F1ConnectRaceDecoder())
    
    func testRaceDecoder() {
        if let path = Bundle.main.path(forResource: "current", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let races = try raceDecoder.decodeRaces(from: data)
                print(races)
            }
            catch {
                XCTAssert(false)
            }
        }
    }
    
    func testFetchCurrentSeasonRaces() {
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
    
    func testFetchNextSeasonRace() {
        let didReceiveResponse = expectation(description: #function)
        
        networkManager.fetchNextSeasonRace(resultQueue: .main) { result in
            switch result {
            case .success(let race):
                print(String(describing: race))
                XCTAssert(true)
                
            case .failure(let failure):
                print(failure.localizedDescription)
                XCTAssert(false)
            }
            didReceiveResponse.fulfill()
        }
        wait(for: [didReceiveResponse], timeout: 10)
    }


//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
