//
//  MenuViewDelegate.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


protocol MenuViewDelegate {
    func onLogoutSuccess( msg: String )
    func onLogoutError( msg: String )
}
