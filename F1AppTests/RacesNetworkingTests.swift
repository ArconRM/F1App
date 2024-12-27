//
//  RacesNetworkingTests.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 26.11.2024.
//

import XCTest
@testable import F1App

final class RacesNetworkingTests: XCTestCase {
    let raceDecoder = RaceDecoderF1Connect()
    let driversDecoder = DriverDecoderF1Connect()
    let teamDecoder = TeamDecoderF1Connect()
    let driversChampionshipDecoder = DriversChampionshipDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())
    let constructorsChampionshipDecoder = ConstructorsChampionshipDecoderF1Connect(teamDecoder: TeamDecoderF1Connect())
    
    let raceNetworkManager = RacesNetworkServiceImpl(urlSource: UrlSourceF1Connect(), raceDecoder: RaceDecoderF1Connect())
    
    func testRaceDecoder() {
        if let path = Bundle.main.path(forResource: "1", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let races = try raceDecoder.decodeRace(from: data)
                print(races)
            }
            catch {
                XCTAssert(false)
            }
        }
    }
    
    func testRacesDecoder() {
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
    
    func testDriverChampionshipDecoder() {
        if let path = Bundle.main.path(forResource: "drivers-championship", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let championship = try driversChampionshipDecoder.decodeDriversChampionship(data)
                print(championship)
            }
            catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testConstructorsChampionshipDecoder() {
        if let path = Bundle.main.path(forResource: "constructors-championship", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let championship = try constructorsChampionshipDecoder.decodeConstructorsChampionship(data)
                print(championship)
            }
            catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
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


//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
