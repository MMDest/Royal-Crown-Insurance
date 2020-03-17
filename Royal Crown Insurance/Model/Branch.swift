//
//  Branch.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/16/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import Foundation
import GoogleMaps

struct Branch: Decodable {
    var idBranch: Int
    var title: String
    var address: String
    var phone: String
    var fax: String
    var email: String
    var postalCode: String
    var latitude: Double
    var longitude: Double
    func position() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    enum CodingKeys: String, CodingKey {
        case idBranch = "id"
        case title
        case address
        case phone
        case fax
        case email
        case postalCode = "postal_kode"
        case latitude
        case longitude
    }
}
