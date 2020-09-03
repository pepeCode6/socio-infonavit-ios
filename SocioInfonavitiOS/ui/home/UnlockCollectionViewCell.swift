//
//  UnlockCollectionViewCell.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import UIKit
import SDWebImage
class UnlockCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lbDescount: UILabel!
    @IBOutlet weak var lbTerritory: UILabel!
    @IBOutlet weak var lbCad: UILabel!
    @IBOutlet weak var ivLocked: UIImageView!
    @IBOutlet weak var btnLocked: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func renderRow(benefit: Benefit) {
        
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        
        self.layer.masksToBounds = false
        
        
        if benefit.status == "locked"{

            ivLocked.isHidden = false
            btnLocked.isHidden = false

            ivLocked.sd_setImage(with: URL(string: benefit.vector_full_path!))
            
            lbDescount.isHidden = true
            viewHeader.isHidden = true
            lbTerritory.isHidden = true
            lbCad.isHidden = true
            ivLogo.isHidden = true
        } else {
            lbDescount.text = benefit.title
            viewHeader.backgroundColor = UIColor(hex: benefit.primary_color!+"ff")
            var territoriesString = ""
            var counting = 0
            benefit.territories?.forEach({ (territory) in
                counting += 1
                territoriesString += "\(String(describing: territory.name!))"
                if counting != benefit.territories?.count{
                    territoriesString += ", "
                }
            })
            lbTerritory.text = territoriesString
            lbCad.text = "Expira el \(String(describing: benefit.expiration_date!))"
            ivLogo.sd_setImage(with: URL(string: (benefit.ally?.mini_logo_full_path!)!))
            
            lbDescount.isHidden = false
            viewHeader.isHidden = false
            lbTerritory.isHidden = false
            lbCad.isHidden = false
            ivLogo.isHidden = false
            
            ivLocked.isHidden = true
            btnLocked.isHidden = true
        }
        
    }

}
