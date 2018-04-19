//
//  ViewController.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/18.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

class Bar1Controller: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
   
    @IBOutlet weak var LeftSideView: UIView!
    @IBOutlet weak var LeftSideBar: UITableView!
    
    var isSideViewOpen:Bool = false
    
    var sidebarData = ["Tasks","Settings","Search"]
    var sidebarIcon = [#imageLiteral(resourceName: "list"),#imageLiteral(resourceName: "settings-2"),#imageLiteral(resourceName: "search-2")];
    var sidebarColor =  [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidebarData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SideBarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell") as! SideBarTableViewCell
        cell.img.image = sidebarIcon[indexPath.row]
        cell.label.text = sidebarData[indexPath.row]
        cell.contentView.backgroundColor = sidebarColor[indexPath.row]
        return cell
    }
    
    func animateTable(){
        LeftSideBar.reloadData()
        let cells = LeftSideBar.visibleCells
        let tableViewHeight = LeftSideBar.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX:0,y:tableViewHeight)
        }
        
        var delayCounter = 0;
        for cell in cells{
            UIView.animate(withDuration: 1.2, delay: Double(delayCounter)*0.05, usingSpringWithDamping: 0.8, initialSpringVelocity:0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            LeftSideView.isHidden = true;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnLeftSideBar(_ sender: Any) {
        
        LeftSideView.isHidden = false;
        self.view.bringSubview(toFront: LeftSideView)
        
        if !isSideViewOpen{
            isSideViewOpen = true
//            LeftSideView.frame = CGRect(x:0,y:64,width:0,height:270)
//            LeftSideBar.frame = CGRect(x:0,y:0,width:0,height:270)
//            UIView.setAnimationDuration(1)
//            UIView.setAnimationDelegate(self)
//            UIView.beginAnimations("TableAnimation", context: nil)
//            LeftSideView.frame =  CGRect(x:0,y:99,width:110,height:270)
//            LeftSideBar.frame = CGRect(x:0,y:0,width:110,height:270)
//            UIView.commitAnimations()
        }else{
            LeftSideView.isHidden = true;
            isSideViewOpen = false

        }
        animateTable()

    }
    
}

