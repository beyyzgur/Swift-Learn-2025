//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by beyyzgur on 21.08.2025.
//

import UIKit
import RxSwift
import RxCocoa

class CryptoViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var cryptoList = [CryptoModel]()
    var cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegatesandDataSources()
        setupBindings()
        cryptoVM.fetchURL()
    }
    
    func setDelegatesandDataSources() {
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func setupBindings() {
        cryptoVM
            .loading
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
//        cryptoVM
//            .cryptos
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { cryptos in
//                self.cryptoList = cryptos
//                self.tableView.reloadData()
//            }
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) { row, item, cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
    }
    
}

//extension CryptoViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cryptoList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        var content = cell.defaultContentConfiguration()
//        content.text = cryptoList[indexPath.row].currency
//        content.secondaryText = cryptoList[indexPath.row].price
//        cell.contentConfiguration = content
//        return cell
//    }
//}
