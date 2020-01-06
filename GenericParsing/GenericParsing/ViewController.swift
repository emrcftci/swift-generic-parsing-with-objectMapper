//
//  ViewController.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import Alamofire
import ObjectMapper
import UIKit

class ViewController: UIViewController {

  // MARK: - Outlets

  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var detailTitleLabel: UILabel!
  @IBOutlet private weak var detailLabel: UILabel!

  // MARK: - Properties

  /// Configured data for display view
  private var data: ViewModelProtocol? {
    didSet {
      configureView()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
  }

  // MARK: - Private Helpers

  /// Configure view with final values
  private func configureView() {
    nameLabel.text = data?.name
    detailTitleLabel.text = data?.detailTitle
    detailLabel.text = data?.detail
  }
}

// MARK: - Network

private extension ViewController {

  /// Basic `.get` request with `Alamofire`
  ///
  /// Line 58 `let url ...` will change after every builds !!! 👽
  /// Please check `Scripts/change-url-script.playground`
  func fetchData() {

    /// This url changes every time you build the project ( CMD + B)
    /// Custom build script changes this url, please check Project > Build Phases > Change URL Script
//<change>
    let url = "https://emrcftci.github.io/demo.github.io/generic-parsing-example/space.json"
//</change>
    Alamofire.request(url).responseJSON { [weak self] response  in
      let json = try! JSONSerialization.jsonObject(with: response.data!)

      let genericResponse = Mapper<AnyResponse>().map(JSON: json as! [String : Any])

      /// Set data and call `configureView`
      self?.data = genericResponse?.data
    }
  }
}
