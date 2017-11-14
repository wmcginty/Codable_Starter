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
    let episodes: [Episode]
    var rating: Int?
    let secret: Data?
    
    private enum CodingKeys: String, CodingKey {
        case title, network
        case episodeCount = "episode_count"
        case overviewURL = "overview_url"
        case characters = "character_list"
        case episodes
        case rating
        case secret
    }
    
    struct Episode: Decodable {
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

do {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")
    decoder.dataDecodingStrategy = .base64
    
    let object = try decoder.decode(Show.self, from: json)
    print(object)
    
    let secret = String(data: object.secret!, encoding: .utf8)!
    print(secret)
    
    let titles = object.episodes.map { $0.title }
    print(titles)
    
} catch {
    print(error)
}

let episodes = [Show.Episode(identifier: 2, title: "My Mentor", airDate: Date(timeIntervalSince1970: 1234567), viewerCount: 4200000),
                 Show.Episode(identifier: 12, title: "My Blind Date", airDate: Date(timeIntervalSince1970: 345678), viewerCount: .nan),
                 Show.Episode(identifier: 14, title: "My Drug Buddy", airDate: Date(timeIntervalSince1970: 567890), viewerCount: .infinity)]

let show = Show(title: "Scrubs", network: "ABC", episodeCount: 169, overviewURL: URL(string: "https://en.wikipedia.org/wiki/Scrubs_(TV_series)")!, characters: ["JD", "Elliot", "Turk", "Carla", "Dr Cox", "Dr Kelso", "Janitor"], episodes: episodes, rating: 10, secret: nil)
