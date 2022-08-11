//
//  TableViewCell.swift
//  messengerApp
//
//  Created by Burak Altunoluk on 01/08/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
        
    @IBOutlet var rightChatBox: UILabel!
    @IBOutlet var leftChatBox: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            if self.rightChatBox.text != "" {
                self.rightChatBox.alpha = 1
            } else {
                self.rightChatBox.alpha = 0
            }
            
            if self.leftChatBox.text != "" {
                self.leftChatBox.alpha = 1
            } else {
                self.leftChatBox.alpha = 0
            }
        
        rightChatBox.layer.cornerRadius = 20
        leftChatBox.layer.cornerRadius = 20
        rightChatBox.layer.masksToBounds = true
        leftChatBox.layer.masksToBounds = true
    }

}
