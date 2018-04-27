//
//  ExpandableTasks.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/20.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import Foundation
struct ExpandableTasks{
    
    var isExpanded: Bool
    var tasks: [Task] = []
    
}

struct dateSeparateTasks{
    var date:String
    var tasks: [Task] = []
}


struct category{
    var name:String
}

var categoryList:[category] = [
                               category(name: "NONE"),
                               category(name: "WORK"),
                               category(name: "STUDY"),
                               category(name: "GROCERY LIST"),
                               category(name: "HEHE")
                              ]

struct Task{
    
    var taskID : Int
    static var taskCounter: Int = 1
    var title : String
    var setupTime : Date
    var isFinished : Bool = false
    var taskType: category
    
    init(titleName:String, time:Date, type:category) {
        taskID = Task.taskCounter
        Task.taskCounter += 1
        title = titleName
        setupTime = time
        isFinished = false
        taskType = type
    }
}

var taskList:[Task] = []
