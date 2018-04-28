//
//  addTaskVC.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/22.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit
import Foundation


class addTaskVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var taskTemplateTable: UITableView!
    
    @IBOutlet weak var taskInputLabel: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var taskTemplate = ["Call","Meet","Email","Read","Check","Send","Message","Download"]
    var taskIcon = [#imageLiteral(resourceName: "004-mobile-phone"),#imageLiteral(resourceName: "015-chat"),#imageLiteral(resourceName: "014-message"),#imageLiteral(resourceName: "006-newspaper"),#imageLiteral(resourceName: "012-internet"),#imageLiteral(resourceName: "005-paper-plane"),#imageLiteral(resourceName: "008-chat-1"),#imageLiteral(resourceName: "016-cloud")];
    //var sidebarColor =  [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    
//Collection View
    var timeList:[String] = ["  Today","Tomorrow","Custom"]
    var imageList = [#imageLiteral(resourceName: "today"),#imageLiteral(resourceName: "nextDay"),#imageLiteral(resourceName: "someDay")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cellNumber:Int?
        if collectionView == categoryCollectionView{
            
                cellNumber = categoryList.count
        
        }else if collectionView == timeCollectionView{
            
            cellNumber = timeList.count
            
        }
        return cellNumber!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var resultCell: UICollectionViewCell?
        if collectionView == categoryCollectionView{
            let cell: addTask_categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! addTask_categoryCollectionViewCell
            
            cell.categoryLabel.text = categoryList[indexPath.row].name
            cell.checkedButton.setImage(categoryList[indexPath.row].icon, for: .normal)
            
            if selectedCategory != nil && selectedCategory == indexPath {
                cell.checkedButton.isSelected = true
            }else{
                cell.checkedButton.isSelected = false
            }
            resultCell = cell
        }else if collectionView == timeCollectionView{
            let cell: addTask_timeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! addTask_timeCollectionViewCell
            
            cell.checkedButton.setImage(imageList[indexPath.row], for: .normal)
            
            if selectedTime != nil && indexPath == selectedTime{
                cell.checkedButton.isSelected = true
            }else{
                cell.checkedButton.isSelected = false
            }
            cell.timeLabel.text = timeList[indexPath.row]
            resultCell = cell
        }
        
        return resultCell!
    }
    
    var selectedCategory: IndexPath?
    var selectedTime: IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if collectionView == categoryCollectionView{

            selectedCategory = indexPath
            collectionView.reloadData()
            
        }else if collectionView == timeCollectionView{

            selectedTime =  indexPath
            collectionView.reloadData()
            
            if(indexPath.row == 2){
                datePicker.isHidden = false
            }else{
                datePicker.isHidden = true
            }
        }
        
        
        
    }
    
    
    @IBAction func addTaskButton(_ sender: Any) {
        
        
        guard let taskName = taskInputLabel.text else{
            print("o")
            return
        }
        guard let taskCategory = selectedCategory else{
            
            print("hehe")
            return
        }
        
        guard let taskTime = selectedTime else{
            print("hehe1")
            return
        }
        
        let taskType = categoryList[taskCategory.row].name
        let taskDate = generateDate(situation: taskTime)
        
        let newTask:Task = Task(titleName: taskName, time: taskDate, type: taskType)
        print("              DATE WHEN ADDED \(taskDate) ")
        
        taskList.append(newTask)
        print(taskList[0].setupTime)
        let userCalendar = Calendar.current
        let dateComp = userCalendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: taskList[0].setupTime)
        print("MaybeRight:\(dateComp)")
        let taskDay = userCalendar.component(.day, from: taskList[0].setupTime)
        print("Error:\(taskDay)")
       
        self.dismiss(animated: true, completion: nil)
    }
    

    func generateDate(situation:IndexPath) -> Date{
        
        var dateResult: Date?
        switch situation.row{
        case 0:
            dateResult = Date().addingTimeInterval(-14400)      //minus 4 hrs before it comes to work
            
        case 1:
            let tomorrowDate = Date()
            dateResult = tomorrowDate.addingTimeInterval(86400-14400)
            
        case 2:
            dateResult = datePicker.date.addingTimeInterval(-14400)
            
        default: break
        }
        
    
        
        return dateResult!
    }
    
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("hehe")
    }
    
    

}
