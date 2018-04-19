//
//  ViewController.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/18.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

class Bar1Controller: UIViewController {

    
    @IBOutlet weak var LeftSideBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeftSideBar.isHidden = true;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnLeftSideBar(_ sender: Any) {
        
        LeftSideBar.isHidden = false;
        
    }
    
}

