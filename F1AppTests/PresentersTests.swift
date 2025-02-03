//
//  PresentersTests.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 01.02.2025.
//

import XCTest
@testable import F1App

final class PresentersTests: XCTestCase {
    
    var racesNetworkService: RacesNetworkService!
    var roundResultsNetworkService: RoundResultsNetworkService!
    var standingsChampionshipNetworkService: StandingsNetworkService!
    
    var schedulePresenter: SchedulePresenter!
    var scheduleView: ScheduleViewMock!
    
    var roundDetailsPresenter: RoundDetailsPresenter!
    var roundDetailsView: RoundDetailsViewMock!
    
    var driversChampionshipPresenter: DriversChampionshipPresenter!
    var driversChampionshipView: DriversChampionshipViewMock!
    
    var driverDetailsPresenter: DriverDetailsPresenter!
    var driverDetailsView: DriverDetailsViewMock!
    
    var constructorsChampionshipPresenter: ConstructorsChampionshipPresenter!
    var constructorsChampionshipView: ConstructorsChampionshipViewMock!
    
    var teamDetailsPresenter: TeamDetailsPresenter!
    var teamDetailsView: TeamDetailsViewMock!
    
    override func setUp() {
        super.setUp()
        
        racesNetworkService = RacesNetworkServiceMock()
        roundResultsNetworkService = RoundResultsNetworkServiceMock()
        standingsChampionshipNetworkService = StandingsNetworkServiceMock()
        
        schedulePresenter = SchedulePresenter(raceNetworkService: racesNetworkService)
        scheduleView = ScheduleViewMock()
        schedulePresenter.view = scheduleView
        
        roundDetailsPresenter = RoundDetailsPresenter(round: Round.mock, roundResultsNetworkService: roundResultsNetworkService)
        roundDetailsView = RoundDetailsViewMock()
        roundDetailsPresenter.view = roundDetailsView
        
        driversChampionshipPresenter = DriversChampionshipPresenter(standingsNetworkService: standingsChampionshipNetworkService)
        driversChampionshipView = DriversChampionshipViewMock()
        driversChampionshipPresenter.view = driversChampionshipView
        
        driverDetailsPresenter = DriverDetailsPresenter(driver: Driver.mock)
        driverDetailsView = DriverDetailsViewMock()
        driverDetailsPresenter.view = driverDetailsView
        
        constructorsChampionshipPresenter = ConstructorsChampionshipPresenter(standingsNetworkService: standingsChampionshipNetworkService)
        constructorsChampionshipView = ConstructorsChampionshipViewMock()
        constructorsChampionshipPresenter.view = constructorsChampionshipView
        
        teamDetailsPresenter = TeamDetailsPresenter(team: Team.mock)
        teamDetailsView = TeamDetailsViewMock()
        teamDetailsPresenter.view = teamDetailsView
    }
    
    func testSchedulePresenterLoaded() {
        schedulePresenter.viewDidLoad()
        
        racesNetworkService.fetchSeasonRaces(year: 2025, resultQueue: .main) { result in
            switch result {
            case .success(let races):
                XCTAssertEqual(self.scheduleView.allRaces, races)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        racesNetworkService.fetchNextSeasonRace(resultQueue: .main) { result in
            switch result {
            case .success(let race):
                XCTAssertEqual(self.scheduleView.nextRace, race)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testRoundDetailsPresenterLoaded() {
        roundDetailsPresenter.viewDidLoad()
        
        XCTAssertEqual(roundDetailsView.baseRoundInfo, Round.mock)
        
        roundResultsNetworkService.fetchRoundResults(year: 2025, roundNumber: Round.mock.roundNumber, resultQueue: .main) { result in
            switch result {
            case .success(let roundResults):
                XCTAssertEqual(self.roundDetailsView.roundResultsInfo, roundResults)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testDriversChampionshipPresenterLoaded() {
        driversChampionshipPresenter.viewDidLoad()
        
        standingsChampionshipNetworkService.fetchDriversChampionship(year: 2025, resultQueue: .main) { result in
            switch result {
            case .success(let driversChampionship):
                XCTAssertEqual(self.driversChampionshipView.driversChampionship, driversChampionship)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testDriverDetailsPresenterLoaded() {
        driverDetailsPresenter.viewDidLoad()
        
        XCTAssertEqual(driverDetailsView.driver, Driver.mock)
    }
    
    func testConstructorsChampionshipPresenterLoaded() {
        constructorsChampionshipPresenter.viewDidLoad()
        
        standingsChampionshipNetworkService.fetchConstructorsChampionship(year: 2025, resultQueue: .main) { result in
            switch result {
            case .success(let constructorsChampionship):
                XCTAssertEqual(self.constructorsChampionshipView.constructorsChampionship, constructorsChampionship)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testTeamDetailsPresenterLoaded() {
        teamDetailsPresenter.viewDidLoad()
        
        XCTAssertEqual(teamDetailsView.team, Team.mock)
    }
}
