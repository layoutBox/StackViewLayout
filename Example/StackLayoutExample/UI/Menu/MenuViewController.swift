//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

enum PageType: Int {
    case intro
    case docExamples
    case autolayout
//    case adjustToContainer
//    case tableView
//    case collectionView
//    case form
//    case relativePositions
//    case multiRelativePositions
//    case autoAdjustingSize
    case unitTests

    case count
    
    var text: String {
        switch self {
        case .intro:                      return "StackLayout's Intro"
        case .docExamples:                return "Doc Examples"
        case .autolayout:                 return "Autolayout"
        case .unitTests:                  return "UnitTests"
        case .count:                      return ""
        }
    }

    var viewController: UIViewController {
        switch self {
        case .intro:            return IntroViewController(pageType: self)
        case .docExamples:      return DocExamplesViewController(pageType: self)
        case .autolayout:       return UIStoryboard.init(name: "Autolayout", bundle: nil).instantiateViewController(withIdentifier: "AutolayoutViewController")
        case .unitTests:        return UnitTestsViewController(pageType: self)
        case .count:                      return UIViewController()
        }
    }
}

class MenuViewController: BaseViewController {
    fileprivate var mainView: MenuView {
        return self.view as! MenuView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "StackLayout Examples"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MenuView()
        mainView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        didSelect(pageType: .unitTests)
    }
}

// MARK: MenuViewDelegate
extension MenuViewController: MenuViewDelegate {
    func didSelect(pageType: PageType) {
        navigationController?.pushViewController(pageType.viewController, animated: true)
    }
}
