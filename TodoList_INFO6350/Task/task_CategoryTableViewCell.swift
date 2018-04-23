//
//  task_CategoryTableViewCell.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/23.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

class task_CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryName: UILabel!
    
    @IBOutlet weak var blueBlock: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
