//
//  NetworkServicesTests.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 26.11.2024.
//

import XCTest
@testable import F1App

final class NetworkServicesTests: XCTestCase {
    let raceNetworkManager = RacesNetworkServiceImpl(
        urlSource: UrlSourceF1Connect(),
        raceDecoder: RaceDecoderF1Connect(
            circuitDecoder: CircuitDecoderF1Connect(),
            driverDecoder: DriverDecoderF1Connect(),
            teamDecoder: TeamDecoderF1Connect()
        )
    )
    
    func testFetchCurrentSeasonRaces() {
        let didReceiveResponse = expectation(description: #function)
        
        raceNetworkManager.fetchCurrentSeasonRaces(resultQueue: .main) { result in
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
        
        raceNetworkManager.fetchNextSeasonRace(resultQueue: .main) { result in
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
}
