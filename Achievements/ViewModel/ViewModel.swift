//
//  ViewModel.swift
//  Achievements
//
//  Created by Kurt Kim on 2020-08-20.
//  Copyright © 2020 Kurt Kim. All rights reserved.
//

import CoreData
import UIKit

struct ViewModel {
    
    var fetchedUsers: [NSManagedObject] = []
    let initialData = InitialData()
    var personalRecords: [String] = []
    var virtualRaces: [String] = []
    let personalRecordNames = ["Longest Run", "Highest Elevation", "Fastest 5K", "10K", "Half Marathon", "Marathon"]
    let virtualRaceNames = ["Virtual Half Marathon Race", "Tokyo-Hakone Ekiden 2020", "Virtual 10K Race", "Hakone Ekiden", "Mizuno Singapore Ekiden 2015", "Virtual 5K Race"]
    var leftSide: [String] = []
    var rightSide: [String] = []
    
    mutating func fetchUsers(){
        let fetch = CoreDataManager.shared.fetch(entity: "UserInfo")
        if fetch.count != 0 {
            self.fetchedUsers = fetch
            self.personalRecords = self.dataToArray(string: self.fetchedUsers[0].value(forKey: "personalRecords") as! String)
            self.virtualRaces = self.dataToArray(string: self.fetchedUsers[0].value(forKey: "virtualRaces") as! String)
        }
    }
    
    func saveInitialData(){
        let user = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: CoreDataManager.shared.context)
        user.setValue(self.initialData.userId, forKey: "userID")
        user.setValue(self.stringArrayToString(array: self.initialData.personalRecords), forKey: "personalRecords")
        user.setValue(self.stringArrayToString(array: self.initialData.virtualRaces), forKey: "virtualRaces")
        CoreDataManager.shared.save()
    }
    
    func stringArrayToString(array: [String]) -> String {
        return array.description
    }
    
    func dataToArray(string: String) -> [String] {
        let stringAsData = string.data(using: String.Encoding.utf16)
        let dataToArray: [String] = try! JSONDecoder().decode([String].self, from: stringAsData!)
        return dataToArray
    }
    
    func imageLoader(indexPath: IndexPath) -> (UIImage, UIImage) {
        return (UIImage(named: "\(indexPath.section)-\(indexPath.row)-0")!, UIImage(named: "\(indexPath.section)-\(indexPath.row)-1")!)
    }
    
    func imageResizer(image: UIImage) -> UIImage {
        let cgrect = CGRect(x: 0, y: 0, width: 110, height: 110)
        let cgsize = CGSize(width: 110, height: 110)
        
        var originalImage = image
        UIGraphicsBeginImageContextWithOptions(cgsize, false, 1.0)
        originalImage.draw(in: cgrect)
        originalImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return originalImage
    }
    
    mutating func nameCreator(indexPath: IndexPath) -> (String, String) {
        var leftName = ""
        var rightName = ""
        if indexPath.section == 0 {
            self.leftOrRight(source: self.personalRecordNames)
            leftName = self.leftSide[indexPath.row]
            rightName = self.rightSide[indexPath.row]
            self.leftSide.removeAll()
            self.rightSide.removeAll()
        } else {
            self.leftOrRight(source: self.virtualRaceNames)
            leftName = self.leftSide[indexPath.row]
            rightName = self.rightSide[indexPath.row]
            self.leftSide.removeAll()
            self.rightSide.removeAll()
        }
        return (leftName, rightName)
    }

    mutating func detailCreator(indexPath: IndexPath) -> (String, String) {
        var leftDetail = ""
        var rightDetail = ""
        if indexPath.section == 0 {
            self.leftOrRight(source: self.personalRecords)
            leftDetail = self.leftSide[indexPath.row]
            rightDetail = self.rightSide[indexPath.row]
            self.leftSide.removeAll()
            self.rightSide.removeAll()
        } else {
            self.leftOrRight(source: self.virtualRaces)
            leftDetail = self.leftSide[indexPath.row]
            rightDetail = self.rightSide[indexPath.row]
            self.leftSide.removeAll()
            self.rightSide.removeAll()
        }
        return (leftDetail, rightDetail)
    }
    
    mutating func leftOrRight(source: [String]){
        for i in 0...source.count-1 {
            if i % 2 == 0 {
                self.leftSide.append(source[i])
            } else {
                self.rightSide.append(source[i])
            }
        }
    }
}


