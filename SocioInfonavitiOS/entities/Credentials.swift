//
//  Credentials.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


struct Credentials: Codable {
    let user: UserCredentials
}

struct UserCredentials: Codable {
    let email: String
    let password: String
}
