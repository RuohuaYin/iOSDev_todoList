//
//  CalendarVCViewController.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/23.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit
import Foundation


class CalendarVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var MonthLabel: UILabel!
    
    @IBOutlet weak var Calendar: UICollectionView!
    
    @IBOutlet weak var calendarTaskTable: UITableView!
    
    let Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    let DaysOfMonth = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth:String = String()
    
    var NumberOfEmptyBox = Int()
    
    var NextNumberOfEmptyBox = Int()
    
    var PreviousNumberOfEmptyBox = 0
    
    var Direction = 0   //=0 if we are at the current month, =1 if we are in a future month, =-1 if we are in a past month
    
    var PositionIndex = 0   //we store the above vars of the empty boxes
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        
        updateDateDimensionalArray()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sortTaskByDateAscending()
        diffDateCounter()
        updateDateDimensionalArray()
        calendarTaskTable.reloadData()
        Calendar.reloadData()

        print(dateList)
        
    }
    
    func sortTaskByDateAscending(){
        taskList = taskList.sorted(by: {$0.setupTime.compare($1.setupTime) == .orderedAscending})
        for task in taskList{
            print(task.setupTime)
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        switch currentMonth{
        case "January":
            month = 11
            year -= 1
            Direction = -1
            
            GetStartDateDayPosition()

            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        default:
            month -= 1
            Direction = -1
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth{
        case "December":
            month = 0
            Direction = 1
            year += 1
            
            GetStartDateDayPosition()

            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        default:
            Direction = 1
            
            GetStartDateDayPosition()
            
            month += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    

    func GetStartDateDayPosition(){
        
        switch Direction{
        case 0:
            switch day{
            case 1...7:
                NumberOfEmptyBox = weekday - day
            case 8...14:
                NumberOfEmptyBox = weekday - day - 7
            case 15...21:
                NumberOfEmptyBox = weekday - day - 14
            case 22...28:
                NumberOfEmptyBox = weekday - day - 21
            case 29...31:
                NumberOfEmptyBox = weekday - day - 28
            default:
                break
            }
            PositionIndex = NumberOfEmptyBox
        
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex+DaysInMonths[month]) % 7
            PositionIndex = NextNumberOfEmptyBox
            
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex) % 7)
            if PreviousNumberOfEmptyBox == 7{
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {       // it returns the number of days in the month + the number of "empty boxes"
        //return DaysInMonths[month]// need to be change
        switch Direction{
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: dateCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! dateCollectionViewCell
        
        cell.todayCircleImage.isHidden = true
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        
        if cell.isHidden{
            cell.isHidden = false
        }
       
        cell.selectedBackground.isHidden = true
        
        switch Direction{
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - PositionIndex)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PositionIndex)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PositionIndex)"
        default:
            fatalError()
        
        }
        
        var taskSign:String = ""
        for dateS in dateDimensionalTask{
            for aTask in dateS.tasks{
                let dateComp = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: dateS.date)
                if dateComp.day == Int(cell.DateLabel.text!) && dateComp.month == (month+1) && dateComp.year == year {
                    if aTask.isFinished{
                        taskSign.append("•")
                    }else{
                        taskSign.append("◦")
                    }
                }
            }
            
        }
        cell.taskNumberLabel.text = taskSign
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        if selectedCell==indexPath{
            cell.selectedBackground.isHidden = false
        }
        
        switch indexPath.row{
        case 0,6,7,13,14,20,21,27,28,34,35:
            if Int(cell.DateLabel.text!)! > 0{
                cell.DateLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
        default:
            break
        }
        
        if currentMonth == Months[calendar.component(.month, from: date)-1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day{
            
            cell.todayCircleImage.isHidden = false
            
        }
        
        return cell
    }
    
    var selectedCell:IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: dateCollectionViewCell = collectionView.cellForItem(at: indexPath) as! dateCollectionViewCell
        selectedCell = indexPath
        
        print(month+1)
        print(cell.DateLabel.text)
        print(year)
        
//        let dateComp = userCalendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: taskList[0].setupTime)
        
        for taskStruct in dateDimensionalTask{
            let dateComp = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: taskStruct.date)
            if dateComp.day == Int(cell.DateLabel.text!) && dateComp.month == (month+1) && dateComp.year == Int(year){
                calendarTaskTable.scrollToRow(at:taskStruct.index, at: .top, animated: true)
            }
            //print("ooo: \()")
        }
        collectionView.reloadData()
        
        
        
    }
    
    
    
    //Table View
    
    var dateList:[Date] = []
    var dateDimensionalTask: [dateSeparateTasks] = []
    
    func updateDateDimensionalArray() -> [dateSeparateTasks]{
        dateDimensionalTask = []
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM-dd-YYYY"

        for i in 0..<dateList.count{
            var dateTasks = dateSeparateTasks(date: dateList[i], index: IndexPath(row: 0, section: i), tasks: [])
            for task in taskList{
                let taskDateComp = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: task.setupTime)
                
                let sectionDateComp = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: dateList[i])
               
                if taskDateComp.day == sectionDateComp.day && taskDateComp.month == sectionDateComp.month && taskDateComp.year == sectionDateComp.year {
                    dateTasks.tasks.append(task)
                }

            }
            dateDimensionalTask.append(dateTasks)
        }
        return dateDimensionalTask
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell:calendarTaskHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "calendarTaskHeader") as! calendarTaskHeaderTableViewCell
        cell.DateLabel.text = "\(dateList[section])"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return diffDateCounter()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateDimensionalTask[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CalendarAllTaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "calendarTaskCell", for: indexPath) as! CalendarAllTaskTableViewCell
        cell.taskNameLabel.text = dateDimensionalTask[indexPath.section].tasks[indexPath.row].title
        return cell
        
    }
    
    
    func diffDateCounter() -> Int{
//        let outputFormatter = DateFormatter()
//        outputFormatter.dateFormat = "MM-dd-YYYY"
        dateList = []
        var counter:Int = 0
        var previousDate:Date? = Date().addingTimeInterval(-1000000000)
        print("acdc:\(previousDate)")
        for i in 0..<taskList.count {
            let iDate = taskList[i].setupTime
            let iDateComp = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: taskList[i].setupTime)
            print("\(iDateComp.day)-\(iDateComp.month)-\(iDateComp.year)")
            let prevDateComp = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: previousDate!)
            print("\(prevDateComp.day)-\(prevDateComp.month)-\(prevDateComp.year)")
            if iDateComp.day != prevDateComp.day || iDateComp.month != prevDateComp.month || iDateComp.year != prevDateComp.year {
                dateList.append(iDate)
                counter += 1
            }
            previousDate = iDate
        }
        print("OMG:\(counter)")
        return counter
    }

}
