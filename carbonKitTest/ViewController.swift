//
//  ViewController.swift
//  carbonKitTest
//
//  Created by 長尾 聡一郎 on 2016/03/19.
//  Copyright © 2016年 長尾 聡一郎. All rights reserved.
//

import UIKit
import CarbonKit
import RealmSwift

class ViewController: UIViewController, CarbonTabSwipeNavigationDelegate {

    var nav:CarbonTabSwipeNavigation
    var item = [ String() ]
    
    required init?(coder aDecoder: NSCoder) {
        nav = CarbonTabSwipeNavigation()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
        
    }
    
    func barPositionForCarbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation) -> UIBarPosition {
        return UIBarPosition.Bottom
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch (index % 4) {
        case 0:
            return storyboard.instantiateViewControllerWithIdentifier("edit")
        case 1:
            return storyboard.instantiateViewControllerWithIdentifier("two")
        case 2:
            return storyboard.instantiateViewControllerWithIdentifier("three")
        case 3:
            return storyboard.instantiateViewControllerWithIdentifier("four")
        default:
            return storyboard.instantiateViewControllerWithIdentifier("none")
        }
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAtIndex index: UInt) {
        print("did move at index:",index)
    }
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
        print("unwindToTop")
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.nav.view.removeFromSuperview()
            self.setup()
        }
    }
    
    func setup(){
        item.removeAll()
        
        let realm = try! Realm()
        
        let r = realm.objects(tabname)
        
        if r.count <= 0 {
            
            let addName = tabname()
            
            let r = 1
            
            addName.name = r.description
            print("add Tab name : \(addName.name)")
            
            try! realm.write {
                realm.add(addName)
            }
            
        }
        
        for name in r {
            item.append(name.name)
        }
        
        nav = CarbonTabSwipeNavigation(items: item, delegate: self)
        nav.insertIntoRootViewController(self)
        
        let width:CGFloat = self.view.frame.width / CGFloat(Double(item.count) - 0.5)
        nav.setTabExtraWidth(width)
        
        nav.setSelectedColor(UIColor(red: 0, green: 0, blue: 1, alpha: 1))

    }

}

