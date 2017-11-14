//: [Previous](@previous)

import Foundation

let json = """
{
"title" : "Parks and Recreation",
"network" : "NBC",
"episode_count" : 125,
"overview_url" : "https://en.wikipedia.org/wiki/Parks_and_Recreation",
"character_list" : ["Ben", "Leslie", "Andy", "April", "Chris", "Ron", "Tom", "Ann"],
"rating" : null,
"secret" : "SWYgeW91IGhhdmUgbmV2ZXIgd2F0Y2hlZCBQYXJrcyBhbmQgUmVjcmVhdGlvbiwgeW91IHNob3VsZC4gSXQncyBMSVRFUkFMTFkgdGhlIGJlc3QgdGhpbmcgZXZlci4=",
"episodes" : [
    {
        "title" : "Pilot",
        "identifier" : 1,
        "air_date" : "2001-10-02T00:00:00+0000",
        "viewers" : "Infinity"
    },
    {
        "title" : "Greg Pikitis",
        "identifier" : 13,
        "air_date" : "2003-11-06T00:00:00+0000",
        "viewers" : "Infinity"
    },
    {
        "title" : "Flu Season",
        "identifier" : 32,
        "air_date" : "2006-03-07T00:00:00+0000",
        "viewers" : "-Infinity"
    }
]
}
""".data(using: .utf8)!

struct Show: Decodable {
    let title: String
    let network: String
    let episodeCount: Int
    let overviewURL: URL
    let characters: [String]
    let rating: Int?
    let episodes: [Episode]
    let secret: Data
    
    private enum CodingKeys: String, CodingKey {
        case title, network, rating, episodes, secret
        case episodeCount = "episode_count"
        case overviewURL = "overview_url"
        case characters = "character_list"
    }
    
    struct Episode: Decodable {
        let title: String
        let identifier: Int
        let airDate: Date
        let viewers: Float
        
        private enum CodingKeys: String, CodingKey {
            case title, identifier, viewers
            case airDate = "air_date"
        }
    }
}

do {
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")
    decoder.dataDecodingStrategy = .base64
    
    let show = try decoder.decode(Show.self, from: json)
    
    print("show: \(show)")
    print(show.episodes.map { $0.title })
    
    let airDates = show.episodes.map { $0.airDate }
    let before = airDates.filter { $0 < Date() }
    
    let viewers = show.episodes.map { $0.viewers }
    viewers.forEach { print($0 == -Float.infinity) }
    
    let message = String(data: show.secret, encoding: .utf8)
    print(message)
    
} catch {
    print(error)
}

