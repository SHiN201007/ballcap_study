//
//  DatasourceViewModel.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import Foundation
import RxSwift
import RxCocoa
import KRProgressHUD

struct Data {
  var message: String
}

class DatasourceViewModel {
  
  struct Input {
    
  }
  
  struct Output {
    
  }
  
  private var _input: DatasourceViewModel.Input!
  private var _output: DatasourceViewModel.Output!
  
  private let model = DatasourceModel()
  private let disposeBag = DisposeBag()
  
  private var itemsRelay = BehaviorSubject<[Data]>(value: [])
  
  init(trigger: DatasourceViewModel.Input) {
    _input = trigger
    _output = DatasourceViewModel.Output.init()
    
    // init get
    getDataSource()
    
    // bind
    bind()
  }
  
  private func bind() {
    
  }
  
  // get datasource
  private func getDataSource() {
    model.getDataSource { [weak self] items in
      self?.itemsRelay.onNext(items)
    }
  }
  
  
  // MARK: -- OUTPUT
  func output() -> DatasourceViewModel.Output {
    return _output
  }
}
