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

class DatasourceViewModel {
  
  struct Input {
    
  }
  
  struct Output {
    
  }
  
  private var _input: DatasourceViewModel.Input!
  private var _output: DatasourceViewModel.Output!
  
  private let model = DatasourceModel()
  private let disposeBag = DisposeBag()
  
  init(trigger: DatasourceViewModel.Input) {
    _input = trigger
    _output = DatasourceViewModel.Output.init()
    
    // bind
    bind()
  }
  
  private func bind() {
    
  }
  
  
  // MARK: -- OUTPUT
  func output() -> DatasourceViewModel.Output {
    return _output
  }
}
