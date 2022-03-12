//
//  ChatMessage.swift
//  testtt
//
//  Created by Sheikh Ali on 12/08/2021.
//

import Foundation

class ChatMessage: Codable {
    var body: String
    var updatedAt: String
    var senderName: String
    var senderImage: String?
    var senderId : Int
}
