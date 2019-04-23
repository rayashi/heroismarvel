

import Foundation
import SwiftHash
import Alamofire


class MarvelAPI {
    
    static private let baseURL = "https://gateway.marvel.com:443/v1/public/characters?"
    static private let publicKey = "f9ee21bf37cb5cb87b1dbd25a80f9cd1"
    static private let privateKey = "5be8bd4ad45b849e81fd82a3ee4291300abebc86"
    static private let limit = 50
    
    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "\(ts)&apiKey=\(publicKey)&hash=\(hash)"
    }
    
    class func loadHeros(name: String?, page: Int = 0, onComple: @escaping (MarvelInfo?) -> Void) {
        let offset  = page * limit
        let startWith: String
        if let name = name, !name.isEmpty {
            startWith = "nameStartWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        } else {
            startWith = ""
        }
        let url = baseURL + "offset=\(offset)&limit=\(limit)&" + startWith + getCredentials()
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data,
                  let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data),
                  marvelInfo.code == 200 else {
                onComple(nil)
                return
            }
            
            onComple(marvelInfo)
        }
    }
    
}
