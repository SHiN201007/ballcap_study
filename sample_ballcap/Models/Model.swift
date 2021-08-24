//
//  Model.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import Foundation
import Firebase
import Ballcap

class Model {
  
  // save
  func save(failure: @escaping() -> Void, succsess: @escaping() -> Void) {
    let document: Document<Room.room> = Document()
    document.save(completion: { error in
      if let _error = error {
        print(_error.localizedDescription)
        failure()
      }
      succsess()
    })
  }
  
  // update
  func update(failure: @escaping() -> Void, succsess: @escaping() -> Void) {
    let data = "room name"
    let document: Document<Room.room> = Document(id: "sw2Dgw0yO4WDd1yrGWF6")
    document.data?.name = data
    document.update(completion: { error in
      if let _error = error {
        print(_error.localizedDescription)
        failure()
      }
      succsess()
    })
  }
  
  // add
  func add(text: String, failure: @escaping() -> Void, succsess: @escaping() -> Void) {
    
    let room = Room()
    let batch = Batch()
    
    let document: Document<Message.message> = Document()
    document.data?.text = "test"    
    batch.save(document, to: room.collection(path: .message))
    batch.commit({ error in
      if let _error = error {
        print("error")
        print(_error.localizedDescription)
        failure()
      }
      print("success")
      succsess()
    })
  }
  
  // get data
  func getData(failure: @escaping() -> Void, succsess: @escaping(String) -> Void) {
    let room: Document<Room.room> = Document(id: "sw2Dgw0yO4WDd1yrGWF6")
    _ = room.get { (document, error) in
      if let _error = error {
        print(_error.localizedDescription)
        failure()
      }
      succsess(document?.data?.name ?? "nil")
    }
  }
  
  // get DataSource
  func getDataSource() {
    
  }
}
