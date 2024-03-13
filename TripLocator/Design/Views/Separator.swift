import Foundation
import UIKit
import SnapKit

final class Separator: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    private func setupUI() {
        snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        backgroundColor = .white
    }
}
