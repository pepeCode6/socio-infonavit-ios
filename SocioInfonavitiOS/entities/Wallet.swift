//
//  Wallet.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


struct Wallet: Codable {
    let id: Int?
    let display_index: Int?
    let display_text: String?
    let icon: String?
    let path: String?
    let max_level: Int?
    let avatar: String?
    let name: String?
    let benevit_count: Int?
    let mobile_cover_url: String?
    let desktop_cover_url: String?
//    let member_level: [Int]?
    let primary_color: String?
}
