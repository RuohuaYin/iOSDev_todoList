//
//  ExpandableTasks.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/20.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import Foundation

struct ExpandableNames{
    
    var isExpanded: Bool
    let tasks : [String]
    
}

struct category{
    var name:String
}

var categoryList:[category] = [category(name: "NONE"),
                               category(name: "WORK"),
                               category(name: "STUDY"),
                               category(name: "GROCERY LIST")
                              ]

struct Task{
    
    var taskID : Int
    static var taskCounter: Int = 1
    var title : String
    var setupTime : String
    var isFinished : Bool = false
    var type: category
    
    init(titleName:String, time:String) {
        taskID = Task.taskCounter
        Task.taskCounter += 1

        title = titleName
        setupTime = time
        isFinished = false
        type = categoryList[0]
    }
    
//    private let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    
    
    
    
}
