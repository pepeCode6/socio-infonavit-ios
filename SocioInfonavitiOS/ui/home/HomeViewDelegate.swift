//
//  HomeViewDelegate.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


protocol HomeViewDelegate {
    
    func onGetOrdenedBenefitsSuccess( benefits: [OrdenedBenefit] )
    func onGetOrdenedBenefitsFailure( msg: String  )
    
}


struct OrdenedBenefit {
    
    let wallet: Wallet
    var benefits: [Benefit]
    
    
}
