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
    
    @IBOutlet weak var taskTable: UITableView!
    
    
    var isSideViewOpen:Bool = false
    var selectedTask: IndexPath?
    
    var sidebarTitle = ["Tasks","Settings","Search"]
    var sidebarIcon = [#imageLiteral(resourceName: "list"),#imageLiteral(resourceName: "settings-2"),#imageLiteral(resourceName: "search-2")];
    var sidebarColor =  [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]
    
    
    var sectionNames = ["Today","Tomorrow","Upcoming","Someday","Overdue"]
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, tasks:["Call Daddy","Kick somebody's ass"]),
        ExpandableNames(isExpanded: true, tasks:["Say Hello to","Fetch some of your stuff"]),
        ExpandableNames(isExpanded: true, tasks:["Transfer Money"]),
        ExpandableNames(isExpanded: true, tasks:["Hello World"]),
        ExpandableNames(isExpanded: true, tasks:["哦"])
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeftSideView.isHidden = true;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateSideBar()
    }
    
// [TABLE]
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var secHeight:CGFloat?
    // sidebar table
        if tableView == self.LeftSideBar{
            secHeight = 0
    // task table
        }else if tableView == self.taskTable{
            secHeight = 40
        }
        return secHeight!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: UIButtonType.system)
        //        button.frame = CGRect(x: 0, y: 0, width: 250, height: 34)
        //button.alignmentRect(forFrame: 10)
        button.setTitle("\(sectionNames[section])                                          +", for: .normal)
        
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    
    @objc func handleExpandClose(button:UIButton){
        print("expand/close")
        //close the section here
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].tasks.indices{
            let indexPath = IndexPath(row:row,section:section)
            indexPaths.append(indexPath)
        }
        
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "\(sectionNames[section])                                                 ···":"\(sectionNames[section])                                          +", for: .normal)
        
        if isExpanded{
            taskTable.deleteRows(at: indexPaths, with: .fade)
        }else{
            taskTable.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var secNumber: Int?
    // sidebar table
        if tableView == self.LeftSideBar{
            secNumber = 1
    // task table
        }else if tableView == self.taskTable{
            secNumber = twoDimensionalArray.count
        }
        return secNumber!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        
        var rowNumber: Int?
    // Sidebar table
        if tableView == self.LeftSideBar{
            rowNumber = sidebarTitle.count
            print("rowNumber: \(rowNumber)")
    // task table
        }else if tableView == self.taskTable{
            if !twoDimensionalArray[section].isExpanded{
                rowNumber = 0;
            }else{
                rowNumber = twoDimensionalArray[section].tasks.count
            }
        }
        return rowNumber!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var resultCell: UITableViewCell?
    // sidebar table
        if tableView == self.LeftSideBar{
            let cell:SideBarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell") as! SideBarTableViewCell
            cell.img.image = sidebarIcon[indexPath.row]
            cell.label.text = sidebarTitle[indexPath.row]
            cell.contentView.backgroundColor = sidebarColor[indexPath.row]
            resultCell = cell
            
    // task table
        }else if tableView == self.taskTable{
            let cell:AllTaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! AllTaskTableViewCell
        //cell.link = self
            let taskName = twoDimensionalArray[indexPath.section].tasks[indexPath.row]
            cell.TaskTitle.text = taskName
            resultCell = cell
        }
        
        return resultCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    // sidebar table
        if tableView == self.LeftSideBar{
            print(indexPath.row)
    // task table
        }else if tableView == self.taskTable{
            var updateIndexPaths: [IndexPath] = []
            if selectedTask != indexPath{
                selectedTask = indexPath
                updateIndexPaths.append(selectedTask!)
                updateIndexPaths.append(indexPath)
                self.taskTable.reloadRows(at: updateIndexPaths, with: .automatic)
            }else{
                selectedTask = nil
                updateIndexPaths.append(indexPath)
                self.taskTable.reloadRows(at: updateIndexPaths, with: .automatic)
            }
            
        }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight: CGFloat?
    // sidebar table
        if tableView == self.LeftSideBar{
            rowHeight = 40
    // task table
        }else if tableView == self.taskTable{
            if selectedTask == indexPath {
                rowHeight = 90
            }else{
                rowHeight = 35
            }
        }
       return rowHeight!
    }
    
    func animateSideBar(){
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
    
    
    
// [Button] SideBar

    @IBAction func btnLeftSideBar(_ sender: Any) {
        
        print(123)
        LeftSideView.isHidden = false;
        self.view.bringSubview(toFront: LeftSideView)
        
        if !isSideViewOpen{
              isSideViewOpen = true
              self.LeftSideView.alpha = 1.0
              animateSideBar()
        }else{
            isSideViewOpen = false
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.LeftSideView.alpha = 0.0
            }, completion: nil)
            LeftSideView.isHidden = true;
        }
    }
    

}
