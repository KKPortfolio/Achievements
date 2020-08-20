//
//  AchievementsViewController.swift
//  Achievements
//
//  Created by Kurt Kim on 2020-08-18.
//  Copyright © 2020 Kurt Kim. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController {
    
    @IBOutlet weak var AchievementsTableView: UITableView!
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFirstLaunch() {
            self.viewModel.saveInitialData()
        }
        setupTableView()
    }
}

extension AchievementsViewController {
    
//    if app is launched for the first time, create demo user
    func isFirstLaunch() -> Bool {
        if (!UserDefaults.standard.bool(forKey: "launched_before")) {
            UserDefaults.standard.set(true, forKey: "launched_before")
            return true
        }
        return false
    }
    
    func setupTableView(){
        self.viewModel.fetchUsers()
        AchievementsTableView.delegate = self
        AchievementsTableView.dataSource = self
        AchievementsTableView.allowsSelection = false
        AchievementsTableView.separatorStyle = .none
        AchievementsTableView.reloadData()
    }
}

extension AchievementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(exactly: 220)!
    }
//    custom header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 28))
            headerView.backgroundColor = #colorLiteral(red: 0.8975767493, green: 0.9026047587, blue: 0.9150081873, alpha: 1)
            
            let headerTitle = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width, height: 28))
            headerTitle.text = "Personal Records"
            headerTitle.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
            headerTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            headerTitle.textAlignment = .left
            
            let headerDetail = UILabel(frame: CGRect(x: -15, y: 0, width: tableView.frame.width, height: 28))
            headerDetail.text = "5 of 6"
            headerDetail.font = UIFont(name: "HelveticaNeue-Light", size: 15)
            headerDetail.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            headerDetail.textAlignment = .right
            
            headerView.addSubview(headerTitle)
            headerView.addSubview(headerDetail)
            
            return headerView
            
        } else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 28))
            headerView.backgroundColor = #colorLiteral(red: 0.9181985259, green: 0.9115611911, blue: 0.9232804179, alpha: 1)
            
            let headerTitle = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width, height: 28))
            headerTitle.text = "Virtual Races"
            headerTitle.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
            headerTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            headerTitle.textAlignment = .left
            
            headerView.addSubview(headerTitle)
                    
            return headerView
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementsCell", for: indexPath) as! AchievementsTableViewCell
//        load images
        let images = self.viewModel.imageLoader(indexPath: indexPath)
        cell.leftImage.image = self.viewModel.imageResizer(image: images.0)
        cell.rightImage.image = self.viewModel.imageResizer(image: images.1)
//        load names
        let names = self.viewModel.nameCreator(indexPath: indexPath)
        cell.leftName.text = names.0
        cell.rightName.text = names.1
        cell.leftName.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        cell.rightName.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        cell.leftName.numberOfLines = 2
        cell.rightName.numberOfLines = 2
//        load details
        let details = self.viewModel.detailCreator(indexPath: indexPath)
        cell.leftDetail.text = details.0
        cell.rightDetail.text = details.1
        cell.leftDetail.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        cell.rightDetail.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        
        if indexPath == [0,2] {
            cell.rightImage.alpha = 0.2
            cell.rightDetail.text = "Not Yet"
            cell.rightName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
            cell.rightDetail.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
        return cell
    }
}
