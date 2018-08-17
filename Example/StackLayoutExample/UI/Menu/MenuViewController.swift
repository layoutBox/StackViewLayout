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
    case layoutModes
    case intro
    case autolayout
    case tableView
    case collectionView

    case count
    
    var text: String {
        switch self {
        case .layoutModes:                return "Layout Modes"
        case .intro:                      return "StackLayout's Intro Example"
        case .autolayout:                 return "Autolayout"
        case .tableView:                  return "UITableView with variable cell's height"
        case .collectionView:             return "UICollectionView with variable cell's height"
        case .count:                      return ""
        }
    }

    var viewController: UIViewController {
        switch self {
        case .layoutModes:      return LayoutModesViewController(pageType: self)
        case .intro:            return UnitTestsViewController(pageType: self)
        case .autolayout:       return UIStoryboard(name: "Autolayout", bundle: nil).instantiateViewController(withIdentifier: "AutolayoutViewController")
        case .tableView:        return TableViewExampleViewController(pageType: self)
        case .collectionView:   return CollectionViewExampleViewController(pageType: self)
        case .count:            return UIViewController()
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
        didSelect(pageType: .intro)
    }
}

// MARK: MenuViewDelegate
extension MenuViewController: MenuViewDelegate {
    func didSelect(pageType: PageType) {
        navigationController?.pushViewController(pageType.viewController, animated: true)
    }
}
