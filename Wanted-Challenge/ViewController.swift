//
//  ViewController.swift
//  Wanted-Challenge
//
//  Created by 홍승현 on 2023/03/03.
//

import UIKit

final class ViewController: UIViewController {
  
  // MARK: - Properties
  
  private let highResolutionImageURLs = [
    "https://plus.unsplash.com/premium_photo-1670147091168-13fd4dd81529?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1543373014-cfe4f4bc1cdf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2096&q=80",
    "https://images.unsplash.com/photo-1516912481808-3406841bd33c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=888&q=80",
    "https://images.unsplash.com/photo-1589633827726-8bb96fb3507b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=532&q=80",
    "https://images.unsplash.com/photo-1626639318129-cd1edf731ce9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"
  ]
  
  // MARK: - UI Components
  
  private let collectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    collectionView.register(
      FooterCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: FooterCollectionReusableView.identifier
    )
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
    return highResolutionImageURLs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
    else { fatalError() }
    
    cell.buttonHandler = { [highResolutionImageURLs] imageView in
      let imageURL = highResolutionImageURLs[indexPath.row]
      // 큰 데이터 이미지면 main thread로 돌릴 시 UI Reponse에 문제가 생길 수 있음.
      // -> global 큐로 실행
      DispatchQueue.global().async {
        // url로 이미지를 불러옮
        guard let url = URL(string: imageURL),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data)
        else {
          return
        }
        // 불러온 이미지는 main queue에서 적용 -> UI를 적용하는 것이기 때문이 이를 처리 하지 않으면 에러 발생
        DispatchQueue.main.async {
          imageView.image = image
        }
      }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as? FooterCollectionReusableView
    else { fatalError() }
    return footerView
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: self.view.frame.width - 40, height: 80)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    CGSize(width: self.view.frame.width - 40, height: 40)
  }
}
