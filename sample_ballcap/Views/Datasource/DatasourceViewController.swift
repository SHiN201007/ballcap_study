//
//  DatasourceViewController.swift
//  sample_ballcap
//
//  Created by 松丸真 on 2021/08/24.
//

import UIKit
import RxSwift
import RxCocoa

class DatasourceViewController: UIViewController {
  
  @IBOutlet weak var closeButton: UIButton!
  
  private var viewModel: DatasourceViewModel!
  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    actions()
    bind()
  }
  
  private func actions() {
    closeButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.dismiss(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
  
  
  private func bind() {
    let input = DatasourceViewModel.Input()
    viewModel = DatasourceViewModel(trigger: input)
    
//    let output = viewModel.output()
  }
}
