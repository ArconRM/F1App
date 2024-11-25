//
//  RacesNetworkManagerImpl.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

public struct RacesNetworkManagerImpl: RacesNetworkManager {
    private let urlSource: UrlSource
    
    init(urlSource: UrlSource) {
        self.urlSource = urlSource
    }
    
    public func fetchCurrentSeasonRaces(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ChampionshipRace], any Error>) -> Void
    ) {
        guard let url = URL(string: urlSource.getCurrentSeasonRacesUrl()) else {
            resultQueue.async {
                completionHandler(.failure(NetworkError.urlError))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                print(error)
                completionHandler(.failure(NetworkError.fetchError))
                return
            }
            if let url = Bundle.main.url(forResource: "current", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let racesArray = json["races"] as? [[String: Any]] {
                        var races: [ChampionshipRace] = []
                        for raceJson in racesArray {
                            if let race = try ChampionshipRace(json: raceJson) {
                                races.append(race)
                            }
                        }
                        completionHandler(.success(races))
                    }
                } catch (let error) {
                    completionHandler(.failure(error))
                }
            }
            //            do {
//                if let data = data,
//                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                   let racesJson = json["races"] as? Data {
//                    
//                    let races = try JSONDecoder().decode([ChampionshipRace].self, from: racesJson)
//                    
//                }
//                completionHandler(.success(races))
//            }
//            catch(var error) {
//                completionHandler(.failure(error))
//            }
        }.resume()
    }
    
    public func fetchNextSeasonRace(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<ChampionshipRace, any Error>) -> Void
    ) {
        return
    }
}
