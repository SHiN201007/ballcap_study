//
//  ViewModel.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import Foundation
import RxSwift
import RxCocoa
import KRProgressHUD

class ViewModel {
  
  struct Input {
    var textField: Observable<String>
    var button: Observable<Void>
  }
  
  struct Output {
    var getText: PublishSubject<String>
  }
  
  private var _input: ViewModel.Input!
  private var _output: ViewModel.Output!
  
  private let model = Model()
  private let disposeBag = DisposeBag()
  
  private let updateText = PublishSubject<String>()
  private let getText = PublishSubject<String>()
  
  init(trigger: ViewModel.Input) {
    _input = trigger
    _output = ViewModel.Output.init(getText: getText)
    
    // init get
    getDataSource()
    // bind
    bind()
  }
  
  private func bind() {
    // textField
    _input.textField
      .subscribe(onNext: { [weak self] text in
        self?.updateText(text)
      })
      .disposed(by: disposeBag)
    
    // button
    _input.button
      .subscribe(onNext: { [weak self] in
        self?.add()
      })
      .disposed(by: disposeBag)
  }
  
  // save :: only first
  private func save() {
    KRProgressHUD.show()
    model.save(failure: {
      KRProgressHUD.showError()
    }, succsess: {
      KRProgressHUD.dismiss()
    })
  }
  
  // update
  private func update() {
    KRProgressHUD.show()
    model.update(failure: {
      KRProgressHUD.showError()
    }, succsess: {
      KRProgressHUD.dismiss()
    })
  }
  
  // add
  private func add() {
    KRProgressHUD.show()
    model.add(text: "こんにちは", failure: {
      KRProgressHUD.showError()
    }, succsess: {
      KRProgressHUD.dismiss()
    })
  }
  
  // get data
  private func getData() {
    KRProgressHUD.show()
    model.getData(failure: {
      KRProgressHUD.showError()
    }, succsess: { [weak self] text in
      self?.getText.onNext(text)
      KRProgressHUD.dismiss()
    })
  }
  
  private func getDataSource() {
    model.getDataSource()
  }
  
  
  //MARK: -- Update Value
  private func updateText(_ text: String) {
    updateText.onNext(text)
  }
  
  // MARK: -- OUTPUT
  func output() -> ViewModel.Output {
    return _output
  }
  
}
