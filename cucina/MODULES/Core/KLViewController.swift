//
//  KLViewController.swift
//  cucina
//
//  Created by Manisha on 23/03/19.
//  Copyright © 2019 Manisha. All rights reserved.
//

import Foundation
import UIKit

//class KLViewController: UIViewController {
//    // MARK: - Lifecycle functions
//
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    open override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//
//    open override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//}

import UIKit
// import ChainPageCollectionView

class KLViewController: UIViewController {

    let parentDataSource = ["yelp", "facebook", "netflix", "yahoo", "google", "indeed", "ritual",
                            "sina", "new york time", "gilt"]
    let childImages = ["c1", "c2", "c3", "c4", "c5", "c6"]

    var parentIndex: Int = 0

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Change to Scale Animation", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 237 / 255.0,
                                         green: 231 / 255.0,
                                         blue: 206 / 255.0,
                                         alpha: 1.0)
        return button
    }()

    let chainCollectionView = ChainPageCollectionView(viewType: .customParentHeight(28, 12))

    override func viewDidLoad() {
        super.viewDidLoad()
        button.translatesAutoresizingMaskIntoConstraints = false
        chainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        self.view.addSubview(chainCollectionView)
        self.buildConstraints()
        button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        chainCollectionView.parentCollectionViewItemSize = CGSize(width: 260, height: 390)
        // Do any additional setup after loading the view, typically from a nib.
        chainCollectionView.delegate = self
        chainCollectionView.backgroundColor = UIColor(red: 237 / 255.0,
                                                      green: 231 / 255.0,
                                                      blue: 206 / 255.0,
                                                      alpha: 1.0)
        chainCollectionView.parentCollectionView.register(ImageCardCollectionViewCell.self,
                                                          forCellWithReuseIdentifier: String(describing: ImageCardCollectionViewCell.self))
        chainCollectionView.childCollectionView.register(ImageCardCollectionViewCell.self,
                                                         forCellWithReuseIdentifier: String(describing: ImageCardCollectionViewCell.self))
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension KLViewController {
    func buildConstraints() {
        if #available(iOS 11, *) {
            self.button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            self.button.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.chainCollectionView.topAnchor).isActive = true
        self.chainCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.chainCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        if #available(iOS 11, *) {
            self.chainCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.chainCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }

    @objc func buttonTapped(button: UIButton) {
        if chainCollectionView.childAnimationType == .slideOutSlideIn {
            button.setTitle("Change to Slide Animation", for: .normal)
            chainCollectionView.childAnimationType = .shrinkOutExpandIn
        } else {
            button.setTitle("Change to Scale Animation", for: .normal)
            chainCollectionView.childAnimationType = .slideOutSlideIn
        }
    }
}

extension KLViewController: ChainPageCollectionViewProtocol {
    func parentCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parentDataSource.count
    }

    func parentCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCardCollectionViewCell.self), for: indexPath)
        if let vCell = cell as? ImageCardCollectionViewCell {
            vCell.backGroundImageView.image = UIImage(named: parentDataSource[indexPath.row])
        }
        return cell
    }


    func childCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childImages.count
    }

    func childCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCardCollectionViewCell.self), for: indexPath)
        if let vCell = cell as? ImageCardCollectionViewCell {
            if indexPath.row == 0 {
                vCell.backGroundImageView.image = UIImage(named: parentDataSource[self.parentIndex])
            } else {
                vCell.backGroundImageView.image = UIImage(named: childImages[indexPath.row])
            }
        }
        return cell
    }

    func childCollectionView(_ collectionView: UICollectionView, parentCollectionViewIndex: Int) {
        //chainCollectionView.childCollectionViewDataReady = true
        // NOTE: Add a little delay to let childCollectionView/layout updates its data.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.parentIndex = parentCollectionViewIndex
            self.chainCollectionView.childCollectionViewDataReady = true
        })
    }
}
