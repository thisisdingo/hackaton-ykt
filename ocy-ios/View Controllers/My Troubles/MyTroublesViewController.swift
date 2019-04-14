//
//  MyTroublesViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import SkeletonView

class MyTroublesViewController : UITableViewController {
    
    var interactor : MyTroublesInteractor!
    
    var myTroubles = [Trouble]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor = MyTroublesInteractor.init()
        interactor.delegate = self
        
        tableView.register(UINib(nibName: "MyTroubleTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTroubleTableViewCell")
    }
    
}

extension MyTroublesViewController : SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MyTroubleTableViewCell"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTroubleTableViewCell") as! MyTroubleTableViewCell
        
        let trouble = myTroubles[indexPath.row]
        
        cell.troubleHeader.text = trouble.header
        cell.troubleMessage.text = trouble.message
        cell.troubleCategory.text = trouble.category?.title ?? ""
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTroubles.count
    }
}

extension MyTroublesViewController : MyTroublesInteractorDelegate {
    
    func showLoading() {
        self.view.startSkeletonAnimation()
    }
    
    func hideLoading() {
        self.view.hideSkeleton()
    }
    
    func didFetchTroubles(_ trouble: [Trouble]) {
        self.myTroubles = trouble
        self.tableView.reloadData()
    }
    
}
