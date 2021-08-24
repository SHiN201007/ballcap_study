//
//  ViewController.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var button: UIButton!
  
  private var viewModel: ViewModel!
  private let disposeBag = DisposeBag()
  

  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
  }

  private func bind() {
    let input = ViewModel.Input(textField: textField.rx.text.orEmpty.asObservable(),
                                button: button.rx.tap.asObservable())
    viewModel = ViewModel(trigger: input)
    // output
    let output = viewModel.output()
    output.getText.asObservable()
      .bind(to: label.rx.text)
      .disposed(by: disposeBag)
  }

}

