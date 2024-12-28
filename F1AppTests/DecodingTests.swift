//
//  DecodingTests.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import XCTest
@testable import F1App

class DecodingTests: XCTestCase {
    let circuitDecoder = CircuitDecoderF1Connect()
    let driversDecoder = DriverDecoderF1Connect()
    let teamDecoder = TeamDecoderF1Connect()
    let raceDecoder = RaceDecoderF1Connect(circuitDecoder: CircuitDecoderF1Connect(), driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())
    
    let driversChampionshipDecoder = DriversChampionshipDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())
    let constructorsChampionshipDecoder = ConstructorsChampionshipDecoderF1Connect(teamDecoder: TeamDecoderF1Connect())
    
    let practiceResultDecoder = PracticeResultDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())
    let qualyResultDecoder = QualyResultDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())
    let raceResultDecoder = RaceResultDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())
    
    func testRaceDecoder() {
        if let path = Bundle.main.path(forResource: "1", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let race = try raceDecoder.decodeRace(from: data)
                
                XCTAssert(race != nil)
                
                print(race)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testRacesDecoder() {
        if let path = Bundle.main.path(forResource: "2024", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let races = try raceDecoder.decodeRaces(from: data)
                
                XCTAssert(!races.isEmpty)
                
                print(races)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testDriverChampionshipDecoder() {
        if let path = Bundle.main.path(forResource: "drivers-championship", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let championship = try driversChampionshipDecoder.decodeDriversChampionship(from: data)
                
                XCTAssert(!championship.isEmpty)
                
                print(championship)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testConstructorsChampionshipDecoder() {
        if let path = Bundle.main.path(forResource: "constructors-championship", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let championship = try constructorsChampionshipDecoder.decodeConstructorsChampionship(from: data)
                
                XCTAssert(!championship.isEmpty)
                
                print(championship)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testPracticeResultDecoder() {
        if let path = Bundle.main.path(forResource: "fp1", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try practiceResultDecoder.decodePracticeResults(from: data, practiceNumber: 1)
                
                XCTAssert(!results.isEmpty)
                
                print(results)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testSprintQualyResultDecoder() {
        if let path = Bundle.main.path(forResource: "sprint-qualy", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try qualyResultDecoder.decodeQualyResults(from: data, isSprint: true)
                
                XCTAssert(!results.isEmpty)
                
                print(results)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testQualyResultDecoder() {
        if let path = Bundle.main.path(forResource: "qualy", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try qualyResultDecoder.decodeQualyResults(from: data, isSprint: false)
                
                XCTAssert(!results.isEmpty)
                
                print(results)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testSprintRaceResultDecoder() {
        if let path = Bundle.main.path(forResource: "sprint-race", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try raceResultDecoder.decodeRaceResults(from: data, isSprint: true)
                
                XCTAssert(!results.isEmpty)
                
                print(results)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
    
    func testRaceResultDecoder() {
        if let path = Bundle.main.path(forResource: "race", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try raceResultDecoder.decodeRaceResults(from: data, isSprint: false)
                
                XCTAssert(!results.isEmpty)
                
                print(results)
                
            } catch(let error) {
                print(error)
                XCTAssert(false)
            }
        }
    }
}
