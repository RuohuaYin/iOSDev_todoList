//
//  task_DescriptionVC.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/27.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

class task_DescriptionVC: UIViewController {
    
    
    var link:Bar1Controller?
    var taskToChange:Task?
    
    @IBOutlet weak var taskTitle: UITextField!
    
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBAction func saveBtn(_ sender: Any) {
        if(DescriptionText.text == "Add your description"){
            link?.changeDescriptionAndTitleByIndex(newTitle: taskTitle.text!, newDescription: "")
            
        }else{
            link?.changeDescriptionAndTitleByIndex(newTitle: taskTitle.text!, newDescription: DescriptionText.text)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.text = taskToChange?.title
        if(taskToChange?.taskDescription != ""){
            DescriptionText.text = taskToChange?.taskDescription
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
