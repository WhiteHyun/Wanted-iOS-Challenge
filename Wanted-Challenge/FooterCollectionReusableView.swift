//
//  FooterCollectionReusableView.swift
//  Wanted-Challenge
//
//  Created by 홍승현 on 2023/03/03.
//

import UIKit

final class FooterCollectionReusableView: UICollectionReusableView {
  
  // MARK: - Properties
  
  static let identifier = "\(FooterCollectionReusableView.self)"
  
  var reloadAllHandler: (() -> Void)?
  
  // MARK: - UI Components
  
  private let button = {
    var configuration = UIButton.Configuration.filled()
    configuration.title = "Load All Images"
    let button = UIButton(configuration: configuration)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  // MARK: - Initializations
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayouts()
    setupConstraints()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configurations
  
  private func setupLayouts() {
    self.addSubview(button)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate(
      [
        self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        self.button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10)
      ]
    )
  }
}
