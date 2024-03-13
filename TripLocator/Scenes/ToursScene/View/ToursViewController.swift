import UIKit
import SnapKit
import Kingfisher

protocol ToursDisplayLogic where Self: AnyObject {
    func showError(error: APIError)
    func showResults(offers: [Offer])
    func showLoading()
}

extension ToursViewController: ToursDisplayLogic {
    @MainActor
    func showError(error: APIError) {
        view.hideAnimatedActivityIndicatorView()
        showOkAlert(with: "Error", message: error.localizedDescription) {
            self.dismiss(animated: true)
        }
    }
    
    @MainActor
    func showResults(offers: [Offer]) {
        view.hideAnimatedActivityIndicatorView()
        dataSource = offers
        collectionView.reloadData()
    }
    
    @MainActor
    func showLoading() {
        view.displayAnimatedActivityIndicatorView()
    }
}

extension ToursViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourCell.identifier, for: indexPath) as? TourCell else { fatalError("Could't dequeue cell") }
        cell.setUp(using: dataSource[indexPath.item])
        return cell
    }
}

final class ToursViewController: UIViewController {
    var interactor: ToursBusinessLogic?
    
    private var dataSource: [Offer] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 336)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TourCell.self, forCellWithReuseIdentifier: TourCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Результаты поиска"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .lightGray
        
        configure()
        interactor?.startSearch()
    }
    
    private func configure() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
