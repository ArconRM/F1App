//
//  NetworkServicesF1ConnectAlamofireTests.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 21.03.2025.
//

import Foundation
@testable import F1App
import XCTest

final class NetworkServicesF1ConnectAlamofireTests: XCTestCase {
    var raceNetworkService: RacesNetworkServiceAlamofire!
    var standingsNetworkService: StandingsNetworkServiceAlamofire!
    var roundResultsNetworkService: RoundResultsNetworkServiceAlamofire!
    
    override func setUp() {
        super.setUp()
        raceNetworkService = RacesNetworkServiceAlamofire(
            urlSource: UrlSourceF1Connect(),
            raceDecoder: RaceDecoderF1Connect(
                circuitDecoder: CircuitDecoderF1Connect(),
                driverDecoder: DriverDecoderF1Connect(),
                teamDecoder: TeamDecoderF1Connect()
            )
        )
        
        standingsNetworkService = StandingsNetworkServiceAlamofire(
            urlSource: UrlSourceF1Connect(),
            driversChampionshipDecoder: DriversChampionshipDecoderF1Connect(
                driverDecoder: DriverDecoderF1Connect(),
                teamDecoder: TeamDecoderF1Connect()
            ),
            constructorsChampionshipDecoder: ConstructorsChampionshipDecoderF1Connect(teamDecoder: TeamDecoderF1Connect())
        )
        
        roundResultsNetworkService = RoundResultsNetworkServiceAlamofire(
            urlSource: UrlSourceF1Connect(),
            practiceResultDecoder: PracticeResultDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect()),
            qualyResultDecoder: QualyResultDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect()),
            raceResultDecoder: RaceResultDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())
        )
    }
    
    func testFetchNextSeasonRace() {
        let didReceiveResponse = expectation(description: #function)
        
        raceNetworkService.fetchNextSeasonRace(resultQueue: .main) { result in
            switch result {
            case .success(let race):
                print(String(describing: race))
                XCTAssert(true)
                
            case .failure(let error):
                if let error = error as? LocalizedError {
                    print(error.errorDescription)
                    print(error.failureReason)
                } else {
                    print(error.localizedDescription)
                }
                XCTAssert(false)
            }
            didReceiveResponse.fulfill()
        }
        wait(for: [didReceiveResponse], timeout: 10)
    }
    
    func testFetchSeasonRaces() {
        let didReceiveResponse = expectation(description: #function)
        
        raceNetworkService.fetchSeasonRaces(year: 2024, resultQueue: .main) { result in
            switch result {
            case .success(let races):
                for race in races {
                    print(String(describing: race))
                }
                XCTAssert(true)
                
            case .failure(let error):
                if let error = error as? LocalizedError {
                    print(error.errorDescription)
                    print(error.failureReason)
                } else {
                    print(error.localizedDescription)
                }
                XCTAssert(false)
            }
            didReceiveResponse.fulfill()
        }
        wait(for: [didReceiveResponse], timeout: 10)
    }
    
    func testFetchDriversChampionship() {
        let didReceiveResponse = expectation(description: #function)
        
        standingsNetworkService.fetchDriversChampionship(year: 2024, resultQueue: .main) { result in
            switch result {
            case .success(let championship):
                for entry in championship {
                    print(String(describing: entry))
                }
                XCTAssert(true)
                
            case .failure(let error):
                if let error = error as? LocalizedError {
                    print(error.errorDescription)
                    print(error.failureReason)
                } else {
                    print(error.localizedDescription)
                }
                XCTAssert(false)
            }
            didReceiveResponse.fulfill()
        }
        wait(for: [didReceiveResponse], timeout: 10)
    }
    
    func testFetchConstructorsChampionship() {
        let didReceiveResponse = expectation(description: #function)
        
        standingsNetworkService.fetchConstructorsChampionship(year: 2024, resultQueue: .main) { result in
            switch result {
            case .success(let championship):
                for entry in championship {
                    print(String(describing: entry))
                }
                XCTAssert(true)
                
            case .failure(let error):
                if let error = error as? LocalizedError {
                    print(error.errorDescription)
                    print(error.failureReason)
                } else {
                    print(error.localizedDescription)
                }
                XCTAssert(false)
            }
            didReceiveResponse.fulfill()
        }
        wait(for: [didReceiveResponse], timeout: 10)
    }
    
    func testFetchRoundResults() {
        let didReceiveResponse = expectation(description: #function)
        
        roundResultsNetworkService.fetchRoundResults(year: 2024, roundNumber: 1, resultQueue: .main) { result in
            switch result {
            case .success(let roundResults):
                print(String(describing: roundResults))
                XCTAssert(true)
                
            case .failure(let error):
                if let error = error as? LocalizedError {
                    print(error.errorDescription)
                    print(error.failureReason)
                } else {
                    print(error.localizedDescription)
                }
                XCTAssert(false)
            }
            didReceiveResponse.fulfill()
        }
        wait(for: [didReceiveResponse], timeout: 20)
    }
}
