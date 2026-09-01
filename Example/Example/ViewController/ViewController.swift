//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/9/1.
//

import UIKit
import WWCurrency

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(WWCurrency.shared.values)
        print(WWCurrency.shared.codes)
    }
}

