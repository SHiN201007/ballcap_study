//
//  FirebaseModel.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import Foundation
import Firebase
import Ballcap


//MARK: -- Room
class Room: Object, DataRepresentable & HierarchicalStructurable {
  var data: room?
  var message: [Message] = []
  
  struct room: Modelable & Codable {
    var name: String = ""
  }
  
  enum CollectionKeys: String {
    case message
  }
}

//MARK: -- Message
class Message: Object {
  var data: message?
  
  struct message: Modelable & Codable {
    var text: String = ""
  }
}
