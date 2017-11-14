//: [Previous](@previous)

import Foundation

struct Show: Codable {
    
    let title: String
    let network: String
    let episodeCount: Int
    let overviewURL: URL
    let characters: [String]
    let episodes: [Episode]
    var rating: Int?
    let secret: Data?
    
    private enum CodingKeys: String, CodingKey {
        case title, network
        case episodeCount = "episode_count"
        case overviewURL = "overview_url"
        case characters
        case episodes
        case rating
        case secret
    }
    
    struct Episode: Codable {
        let identifier: Int
        let title: String
        let airDate: Date
        let viewerCount: Float
        
        private enum CodingKeys: String, CodingKey {
            case title, identifier
            case viewerCount = "viewers"
            case airDate = "air_date"
        }
    }
}

let episodes = [Show.Episode(identifier: 2, title: "My Mentor", airDate: Date(timeIntervalSince1970: 1234567), viewerCount: 4200000),
                Show.Episode(identifier: 12, title: "My Blind Date", airDate: Date(timeIntervalSince1970: 345678), viewerCount: .nan),
                Show.Episode(identifier: 14, title: "My Drug Buddy", airDate: Date(timeIntervalSince1970: 567890), viewerCount: .infinity)]

let show = Show(title: "Scrubs", network: "ABC", episodeCount: 169, overviewURL: URL(string: "https://en.wikipedia.org/wiki/Scrubs_(TV_series)")!, characters: ["JD", "Elliot", "Turk", "Carla", "Dr Cox", "Dr Kelso", "Janitor"], episodes: episodes, rating: 10, secret: nil)
