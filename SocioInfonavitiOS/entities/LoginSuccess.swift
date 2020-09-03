//
//  LoginSuccess.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


struct LoginSuccess : Codable{
    let error: String?
    let id: Int?
    let email: String?
    let role: String?
    let sign_in_count: Int?
    let member: Member?
}

struct Member : Codable{
    let id: Int?
    let user_id: Int?
    let id_socio_infonavit: String?
    let name: String?
    let lastname: String?
    let mobile: String?
    let zipcode: Int?
    let avatar: String?
}

