//
//  TableViewCell.swift
//  RxSwift-Ex
//
//  Created by Harditya on 2/9/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Function
    
    func configure(comment: Comment) {
        self.nameLabel.text = comment.name
    }

}
