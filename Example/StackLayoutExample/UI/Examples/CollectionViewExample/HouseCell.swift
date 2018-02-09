// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
// Created by Luc Dion on 2017-10-31.

import UIKit
import StackViewLayout

class HouseCell: UICollectionViewCell {
    static let reuseIdentifier = "HouseCell"

    fileprivate let stackView = StackView()
    fileprivate let nameLabel = UILabel()
    fileprivate let mainImage = UIImageView()
    fileprivate let priceLabel = UILabel()
    fileprivate let distanceLabel = UILabel()

    fileprivate let padding: CGFloat = 8

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = .white

        mainImage.backgroundColor = .black
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true

        distanceLabel.textAlignment = .right

        let footerBackgroundColor = UIColor.stackLayoutColor.withAlphaComponent(0.2)

        stackView.define { (stackView) in
            stackView.addStackView().paddingHorizontal(padding).backgroundColor(.stackLayoutColor).define({ (stackView) in
                stackView.addItem(nameLabel).grow(1)
            })

            stackView.addItem(mainImage).height(300)

            stackView.addStackView().direction(.row).justifyContent(.spaceBetween).padding(6, padding, 6, padding)
                .backgroundColor(footerBackgroundColor).define({ (stackView) in
                stackView.addItem(priceLabel)
                stackView.addItem(distanceLabel).grow(1)
            })
        }
        contentView.addSubview(stackView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(house: House) {
        nameLabel.text = house.name
        mainImage.download(url: house.mainImageURL)
        priceLabel.text = house.price
        distanceLabel.text = "\(house.distance) KM"

        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
    private func layout() {
        stackView.pin.top().horizontally().sizeToFit(.width)
        contentView.pin.height(stackView.frame.height)
    }
}
