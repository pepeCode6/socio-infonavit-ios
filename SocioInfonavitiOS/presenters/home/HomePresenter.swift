//
//  HomePresenter.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import Foundation


class HomePresenter: HomePresenterDelegate{
    
    private var wallets: [Wallet] = []
    private var lockedBenefits: [Benefit] = []
    private var unlockedBenefits: [Benefit] = []
    var ordenedBenefits: [OrdenedBenefit] = [ ]
    
    private var viewDelegate: HomeViewDelegate!
    
    init( viewDelegate: HomeViewDelegate ){
        self.viewDelegate = viewDelegate
        //getWallets()
    }
    
    func getWallets() {
        API.shared.makegetCall(endPoint: "member/wallets") { (result: Result<[Wallet], Error>) in
            switch result{
            case .success(let wallets):
                self.wallets.append(contentsOf: wallets)
                print("carteras: \(self.wallets.count)")
                self.getBenefits()
            case.failure(let error):
                print("Error al traer las carteras")
            }
        }
    }
    
    func getBenefits() {
        API.shared.makegetCall(endPoint: "member/landing_benevits") { (result: Result<BenefitsResponse, Error>) in
            switch result{
            case .success(let benefits):
                self.lockedBenefits.append(contentsOf: benefits.locked ?? [])
                self.unlockedBenefits.append(contentsOf: benefits.unlocked ?? [])
                print("bloqueados: \(self.lockedBenefits.count)")
                print("desbloqueados: \(self.unlockedBenefits.count)")
                self.getOrdenedBenefits()
            case.failure(let error):
                print("Error al traer los beneficios")
            }
        }
    }
    
    func getOrdenedBenefits() {
        self.wallets.forEach { (wallet) in
            var auxOrdenedBenefits = OrdenedBenefit(wallet: wallet, benefits: [])
            self.lockedBenefits.forEach { (locked) in
                if locked.wallet?.id == wallet.id{
                    var auxLockBenefits = locked
                    auxLockBenefits.status = "locked"
                    auxOrdenedBenefits.benefits.append(auxLockBenefits)
                }
            }
            self.unlockedBenefits.forEach { (locked) in
                if locked.wallet?.id == wallet.id{
                    var auxUnlockBenefits = locked
                    auxUnlockBenefits.status = "unlocked"
                    auxOrdenedBenefits.benefits.append(auxUnlockBenefits)
                }
            }
            self.ordenedBenefits.append(auxOrdenedBenefits)
        }
        viewDelegate.onGetOrdenedBenefitsSuccess(benefits: self.ordenedBenefits)
        
    }
    
    
}
