

import Foundation


struct MarvelInfo: Codable {
    
    let code: Int
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}

struct Hero: Codable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    let urls: [HeroUrl]
}

struct Thumbnail: Codable {
    let path: String
    let ext: String
    
    enum CodinKey: String, CodingKey {
        case path
        case ext = "extension"
    }
}
struct HeroUrl: Codable {
    let type: String
    let url: String
}
