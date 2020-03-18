//
//  Instructions.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/18/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import Foundation

struct Instruction: Codable {
    var instructinID: Int
    var instructionsTitle: String
    var isTabs: Bool
    var firstTabTitle: String
    var firstTabContent: String
    var secondTabTitle: String
    var secondTabContent: String
    enum CodingKeys: String, CodingKey {
        case instructinID = "id"
        case instructionsTitle = "title"
        case isTabs = "tabs"
        case firstTabTitle = "tab_1_title"
        case firstTabContent = "tab_1_content"
        case secondTabTitle = "tab_2_title"
        case secondTabContent = "tab_2_content"
    }
}
