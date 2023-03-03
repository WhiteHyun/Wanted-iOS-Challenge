//
//  CollectionViewCell.swift
//  Wanted-Challenge
//
//  Created by 홍승현 on 2023/03/03.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
  static let identifier = "\(CollectionViewCell.self)"
  
  // MARK: - UI Components
  
  private let stackView = {
    let stackView = UIStackView()
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 8
    return stackView
  }()
  
  private let imageView = {
    let imageView = UIImageView(image: UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate))
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let progressView = {
    let progressView = UIProgressView(progressViewStyle: .bar)
    progressView.progress = 0.5
    progressView.trackTintColor = .lightGray
    progressView.translatesAutoresizingMaskIntoConstraints = false
    return progressView
  }()
  
  private let loadButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.title = "Load"
    
    let button = UIButton(configuration: configuration)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  // MARK: - Initializations
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayouts()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configurations
  
  private func setupLayouts() {
    self.contentView.addSubview(stackView)
    
    [imageView, progressView, loadButton].forEach {
      self.stackView.addArrangedSubview($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate(
      [
        self.stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        self.stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        self.stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
        self.stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        self.imageView.widthAnchor.constraint(equalToConstant: 100)
      ]
    )
  }
}