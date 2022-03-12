
//
//  RightChattingTableViewCell.swift
//  testtt
//
//  Created by Sheikh Ali on 11/08/2021.
//

import UIKit

class RightChattingTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak internal var lblMessage: UILabel!
    @IBOutlet weak internal var lblSentDate: UILabel!
    @IBOutlet weak internal var imgBackground: UIImageView!

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imgBackground.roundCorners(corners: [.topRight, .bottomLeft, .topLeft], radius: 8.0)
    }
    
    func setCellData(_ message: ChatMessage) {
        self.lblMessage.text = message.body
        self.lblSentDate.text = message.updatedAt
    }
}

