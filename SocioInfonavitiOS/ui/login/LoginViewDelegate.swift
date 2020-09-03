//
//  LoginViewDelegate.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


protocol LoginViewDelegate {
    
    func onLoginSuccess( msg: String )
    func onLoginFailure( msg: String )
    
    func makeLogin()
    
}
