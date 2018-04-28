//
//  ExpandableTasks.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/20.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import Foundation
import UIKit
struct ExpandableTasks{
    
    var isExpanded: Bool
    var tasks: [Task] = []
    
}

struct dateSeparateTasks{
    var date:Date
    var index:IndexPath
    var tasks: [Task] = []
}


struct category:Decodable{
    var name:String
    var icon:UIImage
}

var categoryList:[category] = [
    category(name: "NONE",icon:#imageLiteral(resourceName: "type_none")),
    category(name: "WORK",icon:#imageLiteral(resourceName: "type_work")),
    category(name: "STUDY",icon:#imageLiteral(resourceName: "type_study")),
    category(name: "GROCERY LIST",icon:#imageLiteral(resourceName: "type_grocery"))
]

struct Task:Decodable{
    
    var taskID : Int
    static var taskCounter: Int = 1
    var title : String
    var setupTime : Date
    var isFinished : Bool = false
    var taskType: category
    var taskDescription: String
    var taskPriority:String
    
    init(titleName:String, time:Date, type:category) {
        taskID = Task.taskCounter
        Task.taskCounter += 1
        title = titleName
        setupTime = time
        isFinished = false
        taskType = type
        taskDescription = ""
        taskPriority = "Mid"
    }
}

var taskList:[Task] = []
