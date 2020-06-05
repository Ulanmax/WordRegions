//
//  ResponseModel.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class ResponseModel<T: Codable>: Codable {
    
    public let count: Int
    public let results: T?
    
    public init(
        count: Int,
        results: T
        ) {
        self.count = count
        self.results = results
    }
    
    private enum CodingKeys: String, CodingKey {
        case count
        case results
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        count = try container.decode(Int.self, forKey: .count)
        results = try? container.decode(T.self, forKey: .results)
    }
}
