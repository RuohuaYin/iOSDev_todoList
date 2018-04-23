//
//  addTaskVC.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/22.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit



class addTaskVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var taskTemplateTable: UITableView!
    
    @IBOutlet weak var taskInputLabel: UITextField!
    var taskTemplate = ["Call","Meet","Email","Read","Check","Send","Message","Download"]
    var taskIcon = [#imageLiteral(resourceName: "004-mobile-phone"),#imageLiteral(resourceName: "015-chat"),#imageLiteral(resourceName: "014-message"),#imageLiteral(resourceName: "006-newspaper"),#imageLiteral(resourceName: "012-internet"),#imageLiteral(resourceName: "005-paper-plane"),#imageLiteral(resourceName: "008-chat-1"),#imageLiteral(resourceName: "016-cloud")];
    //var sidebarColor =  [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTemplate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:taskTemplateCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "taskTemplate", for:indexPath) as! taskTemplateCellTableViewCell
        cell.taskName.text = taskTemplate[indexPath.row]
        cell.taskIcon.image = taskIcon[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:taskTemplateCellTableViewCell = tableView.cellForRow(at: indexPath) as! taskTemplateCellTableViewCell
        taskInputLabel.text = "\(cell.taskName.text!) "
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        animateTable()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func animateTable(){
        taskTemplateTable.reloadData()
        
        let cells = taskTemplateTable.visibleCells
        let tableViewHeight = taskTemplateTable.bounds.size.height
        
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

}
