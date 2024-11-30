//
//  Posts.swift
//  APICallWays
//
//  Created by M1 on 30.11.2024.
//

import Foundation

struct Posts: Identifiable, Decodable {
    var userId, id: Int
    var title, body: String
}
