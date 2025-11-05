//
//  CryptoTableViewCell.swift
//  CryptoCrazy
//
//  Created by beyyzgur on 28.08.2025.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public var item : CryptoModel! {
        didSet {
            currencyLabel.text = item.currency
            priceLabel.text = item.price
        }
    }

}
