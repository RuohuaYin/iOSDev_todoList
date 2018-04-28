//
//  AllTaskTableViewCell.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/19.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

class AllTaskTableViewCell: UITableViewCell {
    
    
    var link: Bar1Controller?
    var indexPath: IndexPath?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    @IBOutlet weak var checkedBox: UIButton!
    
    @IBOutlet weak var TaskTitle: UILabel!

    @IBOutlet weak var deleteLine: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var taskDetail: UILabel!
    
    @IBOutlet weak var priorityImage: UIImageView!
    
    @IBOutlet weak var highImage: UIImageView!
    
    @IBOutlet weak var midImage: UIImageView!
    
    @IBOutlet weak var lowImage: UIImageView!
    
    
    @IBAction func highBtn(_ sender: Any) {
        link?.changePriorityByIndex(newPriority: "High")
        link?.taskTable.reloadData()
    }
    
    @IBAction func midBtn(_ sender: Any) {
        link?.changePriorityByIndex(newPriority: "Mid")
        link?.taskTable.reloadData()
    }
    
    @IBAction func lowBtn(_ sender: Any) {
        link?.changePriorityByIndex(newPriority: "Low")
        link?.taskTable.reloadData()
    }
    
    
    @IBAction func deleteBtn2Tapped(_ sender: Any) {
        link?.deleteTask(index: indexPath!)
        link?.updateTaskList()
        link?.updateTwoDimensionalArray()
        link?.taskTable.reloadData()
    }
    
    
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        
        link?.deleteTask(index: indexPath!)
        link?.updateTaskList()
        link?.updateTwoDimensionalArray()
        link?.taskTable.reloadData()
        
    }
    
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveLinear, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            
            if(sender.isSelected==false){
                self.link?.finishTask(index: self.indexPath!)
            }else{
                self.link?.deFinishTask(index: self.indexPath!)
            }
            
            
            self.link?.updateTaskList()
            self.link?.updateTwoDimensionalArray()
            
            sender.isSelected = !sender.isSelected
            self.TaskTitle.textColor = sender.isSelected ? #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1): #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.deleteLine.alpha = sender.isSelected ? 1 : 0
            self.deleteLine.isHidden = sender.isSelected ? false: true
            self.deleteBtn.isHidden = sender.isSelected ? false:true
            self.deleteLine.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            
                
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveLinear, animations: {
                sender.transform = .identity
                self.deleteBtn.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                    self.deleteBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2))
                    self.deleteLine.transform = .identity
                }, completion: { (success) in
                    UIView.animate(withDuration:0.2,delay:0,options:.curveLinear,animations:{
                        self.deleteBtn.transform = CGAffineTransform(rotationAngle: CGFloat(0))

                        //self.deleteLine.transform = .identity
                    })
                })
            }, completion: nil)
    }
}
}
