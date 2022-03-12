//
//  LeftChattingTableViewCell.swift
//  testtt
//
//  Created by Sheikh Ali on 11/08/2021.
//

import UIKit

class LeftChattingTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak internal var lblMessage: UILabel!
    @IBOutlet weak internal var lblSentDate: UILabel!
    @IBOutlet weak internal var lblSenderFirstName: UILabel!
    @IBOutlet weak internal var imgBackground: UIImageView!
    @IBOutlet weak var smilyButton: UIButton!
    
    var smilyActionCompletion : (() -> ())?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imgBackground.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8.0)
    }
    
    func setCellData(_ message: ChatMessage) {
        self.lblMessage.text = message.body
        self.lblSentDate.text = message.updatedAt
        self.lblSenderFirstName.text = message.senderName
    }
    
    @IBAction func emojiButtonTapped(_ sender: Any) {
        smilyActionCompletion?()
    }
}

