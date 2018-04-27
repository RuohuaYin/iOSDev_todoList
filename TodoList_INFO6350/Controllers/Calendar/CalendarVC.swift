//
//  CalendarVCViewController.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/23.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

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
        //print("dateDimensionArray \(dateDimensionalTask[0].tasks.count)")
        calendarTaskTable.reloadData()
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
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.isHidden = true
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
    
    
    
    
    //Table View
    
    var dateList:[String] = []
    var dateDimensionalTask: [dateSeparateTasks] = []
    
    func updateDateDimensionalArray() -> [dateSeparateTasks]{
        dateDimensionalTask = []
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM/dd/YYYY"

        for i in 0..<dateList.count{
            var dateTasks = dateSeparateTasks(date: dateList[i], tasks: [])
            for task in taskList{
                let taskDate:String = outputFormatter.string(from: task.setupTime)
                if(taskDate == dateList[i]){
                    print("yes")
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
        cell.DateLabel.text = dateList[section]
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
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM/dd/YYYY"
        dateList = []
        var counter:Int = 0
        var previousDate:String? = ""
        for i in 0..<taskList.count {
            let iDate = outputFormatter.string(from: taskList[i].setupTime)
            if(previousDate != iDate){
                dateList.append(iDate)
                counter += 1
            }
            previousDate = iDate
        }
        return counter
    }

}
