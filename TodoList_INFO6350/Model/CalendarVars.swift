//
//  CalendarVars.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/23.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
let weekday = calendar.component(.weekday, from:date)
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year,from: date)
