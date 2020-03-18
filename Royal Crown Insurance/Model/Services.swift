//
//  Services.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/18/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import Foundation

struct Services: Codable {
    var servicesID: Int
    var title: String
    var type: String
    var description: String
    var website: String
    enum CodingKeys: String, CodingKey {
        case servicesID = "id"
        case title
        case type
        case description
        case website
    }
}
