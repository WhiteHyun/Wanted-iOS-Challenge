//
//  ViewController.swift
//  Wanted-Challenge
//
//  Created by 홍승현 on 2023/03/03.
//

import UIKit

final class ViewController: UIViewController {
  
  // MARK: - UI Components
  
  private let collectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  // MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayouts()
    setupConstraints()
    setupStyles()
  }
  
  // MARK: - Configurations
  
  private func setupLayouts() {
    self.view.addSubview(collectionView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate(
      [
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
      ]
    )
  }
  
  private func setupStyles() {
    self.view.backgroundColor = .systemBackground
    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { fatalError() }
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: self.view.frame.width - 40, height: 60)
  }
}
