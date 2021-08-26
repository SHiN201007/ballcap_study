//
//  DatasourceModel.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import Foundation
import Firebase
import Ballcap


class DatasourceModel {
  
  var dataSource: DataSource<Document<Message.message>> = []
 
  // get DataSource
  func getDataSource(_ completion: @escaping(_ items: [Data]) -> Void) {
    var item: [Document<Message.message>] = []
    
    let ref = db.collection(Collection.room.name).document("kBPO6FnWqIgjLtH1KEcj").collection(Collection.message.name)
    dataSource = DataSource<Document<Message.message>>.Query(ref)
      .order(by: "createdAt")
      .dataSource()
      .onChanged({ [weak self] snapshot, documentSnapshot in
        item = documentSnapshot.after
        print("dataSource", self?.dataSource ?? [])
        print("items", item)
        if let modifiedItems = self?.modifiedItems(item) {
          completion(modifiedItems)
        }
      })
      .listen()
  }
  
  private func modifiedItems(_ items: [Document<Message.message>]) -> [Data] {
    var data: [Data] = []
    for item in items {
      if let text = item.data?.text {
        data.append(Data(message: text))
      }
    }
    return data
  }
  
}
