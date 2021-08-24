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
    let document: Document<Test> = Document()
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
    let data = "sample text"
    let test: Document<Test> = Document(id: "tZgHMSM9HLAK5eEVl7SH")
    test.data?.text = data
    test.update(completion: { error in
      if let _error = error {
        print(_error.localizedDescription)
        failure()
      }
      succsess()
    })
  }
  
  // get data
  func getData(failure: @escaping() -> Void, succsess: @escaping(String) -> Void) {
    let test: Document<Test> = Document(id: "tZgHMSM9HLAK5eEVl7SH")
    _ = test.get { (document, error) in
      if let _error = error {
        print(_error.localizedDescription)
        failure()
      }
      succsess(document?.data?.text ?? "nil")
    }
  }
}
