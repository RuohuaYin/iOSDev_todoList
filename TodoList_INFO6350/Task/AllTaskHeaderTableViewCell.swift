//
//  AllTaskHeaderTableViewCell.swift
//  TodoList_INFO6350
//
//  Created by 殷若华 on 2018/4/27.
//  Copyright © 2018年 殷若华. All rights reserved.
//

import UIKit

class AllTaskHeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var HeaderButton: UIButton!
    
    @IBOutlet weak var PlusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
