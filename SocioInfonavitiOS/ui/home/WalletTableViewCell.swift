//
//  WalletTableViewCell.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var lbWalletName: UILabel!
    @IBOutlet weak var cvBenefits: UICollectionView!
    var ordenedBenefit: OrdenedBenefit = OrdenedBenefit(wallet: Wallet(id: 1, display_index: 0, display_text: "", icon: "", path: "", max_level: 0, avatar: "", name: "", benevit_count: 0, mobile_cover_url: "", desktop_cover_url: "", primary_color: ""), benefits: [])
    var benefits: [Benefit] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cvBenefits.register(UINib(nibName: "UnlockCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell_unlock")
        cvBenefits.delegate = self
        cvBenefits.dataSource = self
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        // self.cvBenefits.register(UINib(nibName: "UnlockCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell_unlock")
        
    }
    
    func renderCell( ordenedBenefit: OrdenedBenefit ) {
        self.ordenedBenefit = ordenedBenefit
        lbWalletName.text = self.ordenedBenefit.wallet.name
        cvBenefits.reloadData()
    }
    
    //MARK:-- collection view implementations
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ordenedBenefit.benefits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UnlockCollectionViewCell = cvBenefits.dequeueReusableCell(withReuseIdentifier: "cell_unlock", for: indexPath) as! UnlockCollectionViewCell
        cell.renderRow(benefit: ordenedBenefit.benefits[indexPath.row])
        return cell
        
        
        
    }
}
