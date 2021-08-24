//
//  Model.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import Foundation
import Firebase
import Ballcap

let db = Firestore.firestore()

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
    let document: Document<Room.room> = Document(id: "kBPO6FnWqIgjLtH1KEcj")
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
    let batch = Batch()
    
    let document: Document<Message.message> = Document()
    document.data?.text = text
    
    let ref = db.collection(Collection.room.name).document("kBPO6FnWqIgjLtH1KEcj").collection(Collection.message.name)
    
    batch.save(document, to: ref)
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
    let room: Document<Room.room> = Document(id: "kBPO6FnWqIgjLtH1KEcj")
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
    var dataSource: DataSource<Document<Message.message>> = []
    var item: [Document<Message.message>] = []
    
    let ref = db.collection(Collection.room.name).document("kBPO6FnWqIgjLtH1KEcj").collection(Collection.message.name)
    dataSource = DataSource<Document<Message.message>>.Query(ref)
      .order(by: "createdAt")
      .dataSource()
      .onChanged({ snapshot, documentSnapshot in
        item = documentSnapshot.after
        print("dataSource", dataSource)
        print("items", item)
      })
      .listen()
  }
}


enum Collection {
  case room
  case message
  
  var name: String {
    switch self {
    case .room:
      return "room"
    case .message:
      return "message"
    }
  }
}
