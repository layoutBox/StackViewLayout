//
//  AutolayoutViewController.swift
//  StackLayoutExample
//
//  Created by Luc Dion on 2018-01-14.
//  Copyright (c) 2018 Mirego. All rights reserved.
//
import UIKit
import StackViewLayout

class AutolayoutViewController: UIViewController {
    @IBOutlet private weak var stackView: StackView!
    @IBOutlet private weak var imageView: UIImageView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize the StackView and its items
        stackView.justifyContent(.spaceAround).alignItems(.center).define { (_) in
            imageView.item.aspectRatio().width(100).shrink(1)
        }
    }
}
