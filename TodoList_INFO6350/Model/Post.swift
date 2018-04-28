//
//  Post.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/28.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import Foundation

struct TestTask: Decodable{
    let description: String
    let id:Int
    let isFinished:Bool
    let priority:String
    let setupTime : String
    let title : String
    let type: String
}

//{"data":[{"type":null,"title":"finish presentation slides this morning","setupTime":"2018-04-28T11:07:55.003791","priority":null,"isFinished":false,"id":1,"description":null},{"type":null,"title":"finish presentation slides this morning","setupTime":"2018-04-28T11:08:01.844869","priority":null,"isFinished":false,"id":2,"description":null},{"type":null,"title":"eat breakfast","setupTime":"2018-04-28T11:08:12.244831","priority":null,"isFinished":false,"id":3,"description":null}]}
