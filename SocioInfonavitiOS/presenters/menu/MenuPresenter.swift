//
//  MenuPresenter.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


class MenuPresenter: MenuPresenterDelegate {
    
    private var viewDelegate: MenuViewDelegate!
    
    init(viewDelegate: MenuViewDelegate){
        self.viewDelegate = viewDelegate
    }
    
    
    func doLogout() {
        
        // mandar a llamar al endpoint
        // https://staging.api.socioinfonavit.io/api/v1/logout (DELETE)
        
        LocalStorageManager.shared.removeJWT()
        viewDelegate.onLogoutSuccess(msg: "Hasta la vista baby!")

    }
    
    
    
    
    
}
