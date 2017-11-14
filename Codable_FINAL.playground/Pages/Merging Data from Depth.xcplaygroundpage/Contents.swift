//: [Previous](@previous)

import Foundation

let json = """
{
    "Parks and Recreation": {
        "seasons": 7,
        "episodes": 125
    },
    "Scrubs": {
        "seasons": 8,
        "episodes": 182
    }
}
""".data(using: .utf8)!

struct ShowDatabase: Decodable {
    
    struct Show {
        let title: String
        let seasons: Int
        let episodes: Int
    }
    
    let shows: [Show]

    private struct ShowKey: CodingKey {
        
        //We can represent our coding values as Strings
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        //And/or we can represent our coding values as Ints (in cases where space may be important)
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
        
        //Instead of enum cases, we've defined some static properties to make accessing the "seasons" and "episodes" coding keys easier
        static let seasons = ShowKey(stringValue: "seasons")!
        static let episodes = ShowKey(stringValue: "episodes")!
    }
    
    //MARK: Initializers
    init(shows: [Show]) {
        self.shows = shows
    }
    
    init(from decoder: Decoder) throws {
        var shows = [Show]()
        
        let container = try decoder.container(keyedBy: ShowKey.self)
        //This container will tell us that there are 2 sub-containers here, one keyed by 'Parks and Recreation' and one by 'Scrubs'
        
        for key in container.allKeys {
            
            //We want to decode all of them, so we'll then ask the container for the nested container keyed by each show's name.
            let showContainer = try container.nestedContainer(keyedBy: ShowKey.self, forKey: key)
            
            //At this point, showContainer is a keyed container which should have 2 keys - "seasons" and "episodes"
            let seasons = try showContainer.decode(Int.self, forKey: .seasons)
            let episodes = try showContainer.decode(Int.self, forKey: .episodes)
            
            //We can combine the seasons and episodes values we got with the origina key we used to create a fully fledged show object
            let show = Show(title: key.stringValue, seasons: seasons, episodes: episodes)
            shows.append(show)
        }
        
        //Sure, you could also use map here.
//        let showsB: [Show] = try container.allKeys.map { key in
//            let showContainer = try container.nestedContainer(keyedBy: ShowKey.self, forKey: key)
//            let seasons = try showContainer.decode(Int.self, forKey: .seasons)
//            let episodes = try showContainer.decode(Int.self, forKey: .episodes)
//            return Show(title: key.stringValue, seasons: seasons, episodes: episodes)
//        }
        
        self.init(shows: shows)
    }
}


do {
    let decoder = JSONDecoder()
    let library: ShowDatabase = try decoder.decode(ShowDatabase.self, from: json)
    
    for show in library.shows {
        print("\(show.title) - \(show.seasons) seasons - \(show.episodes) episodes")
    }

    
} catch {
    print(error)
}

print("\n\nThe reverse encoding works just as easily.\n\n")

//MARK: Encodable
extension ShowDatabase: Encodable {

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ShowKey.self)

        for show in shows {
            // Any shows `name` can be used as a key name.
            let nameKey = ShowKey(stringValue: show.title)!
            var productContainer = container.nestedContainer(keyedBy: ShowKey.self, forKey: nameKey)

            // The rest of the keys use static names defined in `ShowKey`.
            try productContainer.encode(show.seasons, forKey: .seasons)
            try productContainer.encode(show.episodes, forKey: .episodes)
        }
    }
}

do {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    let library = ShowDatabase(shows: [
        .init(title: "Lost", seasons: 6, episodes: 121),
        .init(title: "30 Rock", seasons: 7, episodes: 138)
        ])

    let encodedLibrary = try encoder.encode(library)
    print(String(data: encodedLibrary, encoding: .utf8)!)

} catch {
    print(error)
}

//: [Next](@next)
