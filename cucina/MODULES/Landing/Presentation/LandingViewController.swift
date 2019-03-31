//
//  LandingViewController.swift
//  cucina
//
//  Created by Manisha on 21/03/19.
//  Copyright © 2019 Manisha. All rights reserved.
//

import Foundation
import UIKit

class LandingViewController: KLViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = LandingViewModel()
        viewModel.readDataFromJson()
    }
}
