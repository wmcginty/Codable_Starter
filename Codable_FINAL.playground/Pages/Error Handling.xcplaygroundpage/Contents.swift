//: Playground - noun: a place where people can play

import UIKit

let json = """
{
"title" : "Parks and Recreation",
"network" : "NBC",
"episodeCount" : 125,
"overviewURL" : "https://en.wikipedia.org/wiki/Parks_and_Recreation",
"characters" : ["Ben", "Leslie", "Andy", "April", "Chris", "Ron", "Tom", "Ann"],
"rating" : null
}
""".data(using: .utf8)!

struct Show: Codable {
    let title: String
    let network: String
    let episodeCount: Int
    let overviewURL: URL
    let characters: [String]
    let rating: Int?
}

do {
    
    let decoder = JSONDecoder()
    let show = try decoder.decode(Show.self, from: json)
    print(show)
    
} catch DecodingError.dataCorrupted(let context) {
    print("Data is corrupted: \(context)")
} catch DecodingError.keyNotFound(let key, let context) {
    print("Key '\(key)' not found in: \(context)")
} catch DecodingError.typeMismatch(let type, let context) {
    print("Value of type \(type) not correct in: \(context)")
} catch DecodingError.valueNotFound(let type, let context) {
    print("Non-optional of type \(type) not found in: \(context)")
} catch {
    print("Dupe rdar://32783493 if you also want DecodingError.multiple(let errors)")
}
