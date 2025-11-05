//
//  FeedTableViewCell.swift
//  FirebaseInstaClone
//
//  Created by beyyzgur on 29.07.2025.
//

import UIKit
import FirebaseFirestore

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        let firestoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!) {
            
            let updatedLikeCount = ["like": likeCount + 1] as [String: Any]
            firestoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(updatedLikeCount, merge: true)
        }
        
        
    }
    
}
