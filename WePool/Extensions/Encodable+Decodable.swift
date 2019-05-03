//
//  Encodable+Decodable.swift
//  WePool
//
//  Created by Raj Kadiyala on 5/2/19.
//  Copyright © 2019 WePool. All rights reserved.
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}

extension Decodable{
    init?(dictionary value: [String:Any]){
        
        guard JSONSerialization.isValidJSONObject(value) else { return nil }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else { return nil }
        guard let newValue = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
        self = newValue
    }
}
