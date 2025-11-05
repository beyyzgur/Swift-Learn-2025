//
//  FeedViewController.swift
//  FirebaseInstaClone
//
//  Created by beyyzgur on 26.07.2025.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userLikeArray = [Int]()
    var userImageArray = [String]()
    var userDateArray = [Date]()
    var documentIdArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "error in getDataFromFirestore - feed view controller")
                return }
            guard snapshot?.isEmpty == false && snapshot != nil else { return }
            
            self.userEmailArray.removeAll(keepingCapacity: false)
            self.userCommentArray.removeAll(keepingCapacity: false)
            self.userLikeArray.removeAll(keepingCapacity: false)
            self.userImageArray.removeAll(keepingCapacity: false)
            self.userDateArray.removeAll(keepingCapacity: false)
            self.documentIdArray.removeAll(keepingCapacity: false)
            
            for document in snapshot!.documents {
                let documentID = document.documentID
                self.documentIdArray.append(documentID)
                print(documentID)
                
                if let postedBy = document.get("postedBy") as? String {
                    self.userEmailArray.append(postedBy)
                }
                if let comment = document.get("comment") as? String {
                    self.userCommentArray.append(comment)
                }
                if let timestamp = document.get("date") as? Timestamp {
                    let date = timestamp.dateValue()
                    self.userDateArray.append(date)
                }
                if let imgURL = document.get("imgURL") as? String {
                    self.userImageArray.append(imgURL)
                }
                if let like = document.get("like") as? Int {
                    self.userLikeArray.append(like)
                }
            }
            self.tableView.reloadData()
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.emailLabel.text = userEmailArray[indexPath.row]
        cell.dateLabel.text = userDateArray[indexPath.row].convertDateToString()
        let date = userDateArray[indexPath.row]
        let date2 = date.convertDateToString()
        cell.feedImageView.sd_setImage(with: URL(string: userImageArray[indexPath.row]))
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(userLikeArray[indexPath.row])
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension Date {
    func convertDateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy  HH:mm"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
