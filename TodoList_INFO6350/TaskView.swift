//
//  TaskView.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/19.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

//class TaskView: UIViewController,UITableViewDelegate,UITableViewDataSource{
//
//
//    @IBOutlet weak var taskTable: UITableView!
//
//

//    func reloadTables(){
//        var indexPathsToReload = [IndexPath]()
//
//        for section in twoDimensionalArray.indices{
//            for row in twoDimensionalArray[section].tasks.indices
//            {
//                let indexPath = IndexPath(row:row,section:section)
//                indexPathsToReload.append(indexPath)
//            }
//        }
//        taskTable.reloadRows(at: indexPathsToReload, with: .right)
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let button = UIButton(type: UIButtonType.system)
////        button.frame = CGRect(x: 0, y: 0, width: 250, height: 34)
//        //button.alignmentRect(forFrame: 10)
//        button.setTitle("\(sectionNames[section])                                          +", for: .normal)
//
//        button.titleLabel?.textAlignment = .right
//        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
//        button.tag = section
//        return button
//
//    }
//
//    func someMethodIWantToCall(cell: UITableViewCell){
//        let indexPathTapped = taskTable.indexPath(for: cell)
//        print(indexPathTapped)
//    }
    
//    @objc func handleExpandClose(button:UIButton){
//        print("expand/close")
//        //close the section here
//
//        let section = button.tag
//
//        var indexPaths = [IndexPath]()
//        for row in twoDimensionalArray[section].tasks.indices{
//            let indexPath = IndexPath(row:row,section:section)
//            indexPaths.append(indexPath)
//        }
//
//
//        let isExpanded = twoDimensionalArray[section].isExpanded
//        twoDimensionalArray[section].isExpanded = !isExpanded
//
//        button.setTitle(isExpanded ? "\(sectionNames[section])                                                 ···":"\(sectionNames[section])                                          +", for: .normal)
//
//        if isExpanded{
//            taskTable.deleteRows(at: indexPaths, with: .fade)
//        }else{
//            taskTable.insertRows(at: indexPaths, with: .fade)
//        }
//
//
//    }
    
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return twoDimensionalArray.count
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if !twoDimensionalArray[section].isExpanded{
//            return 0
//        }
//        return twoDimensionalArray[section].tasks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:AllTaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! AllTaskTableViewCell
//        cell.link = self
//        let taskName = twoDimensionalArray[indexPath.section].tasks[indexPath.row]
//        cell.TaskTitle.text = taskName
//
//        //cell.contentView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//        return cell
//    }
//

//}
