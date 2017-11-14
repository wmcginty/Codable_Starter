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
