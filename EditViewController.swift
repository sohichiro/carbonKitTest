//
//  EditViewController.swift
//  carbonKitTest
//
//  Created by 長尾 聡一郎 on 2016/03/22.
//  Copyright © 2016年 長尾 聡一郎. All rights reserved.
//

import UIKit
import RealmSwift

class tabname: Object {
    dynamic var name = ""
}

class EditViewController: UIViewController {
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        self.countLabel.text = realm.objects(tabname).count.description
    }
    
    @IBAction func pushAButton2(sender: AnyObject) {
        let realm = try! Realm()

        if let r = realm.objects(tabname).last {
            try! realm.write {
                realm.delete(r)
            }
        }
        
        self.countLabel.text = realm.objects(tabname).count.description
    }
    
    @IBAction func pushAButton(sender: AnyObject) {
        
        let addName = tabname()
        
        let realm = try! Realm()
        let r = ( realm.objects(tabname).count) + 1
        addName.name = r.description
        print("add Tab name : \(addName.name)")
        
        try! realm.write {
            realm.add(addName)
        }
        
        self.countLabel.text = realm.objects(tabname).count.description
    }
}
