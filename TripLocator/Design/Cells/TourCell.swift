import SnapKit
import UIKit
import Kingfisher

final class TourCell: UICollectionViewCell, Reusable {
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .gray
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let featureStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .red
        return stack
    }()
    
    private let timeStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .red
        return stack
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(featureStack)
        contentView.addSubview(timeStack)
        contentView.addSubview(price)
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(170)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
        }
        
        featureStack.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(24)
        }
        
        timeStack.snp.makeConstraints { make in
            make.top.equalTo(featureStack.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(24)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        image.image = nil
        image.kf.cancelDownloadTask()
    }
    
    func setUp(using data: Offer) {
        // tbh I wanted to upload photos for tours using kingfisher, but couldn't find info for picture
        
        title.text = data.title
        price.text = "\(data.price?.total ?? 0) ₽"
    }
}
