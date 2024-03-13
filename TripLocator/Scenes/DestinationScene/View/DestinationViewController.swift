import UIKit
import SnapKit

protocol DestinationDisplayLogic where Self: AnyObject {
    func showDestinations(destinations items: DestinationResponse)
    func showError(error: APIError)
    func showLoading()
}

extension DestinationViewController: DestinationDisplayLogic {
    @MainActor
    func showDestinations(destinations items: DestinationResponse) {
        view.hideAnimatedActivityIndicatorView()
        dataSource = items
        tableView.reloadData()
    }
    
    @MainActor
    func showError(error: APIError) {
        view.hideAnimatedActivityIndicatorView()
    }
    
    @MainActor
    func showLoading() {
        view.displayAnimatedActivityIndicatorView()
    }
}

final class DestinationViewController: UIViewController {
    var interactor: DestinationBusinessLogic?
    
    private var dataSource: DestinationResponse = []
    
    private lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(searchField)
        stack.addArrangedSubview(closeButton)
        return stack.toAutoLayout()
    }()
    
    private var searchField: TLTextField = {
        let field = TLTextField()
        field.placeholder = "Страна, курорт, отель"
        field.backgroundColor = AppColor.elementBackground
        field.layer.cornerRadius = 14
        return field.toAutoLayout()
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.addAction {
            self.dismiss(animated: true)
        }
        return button.toAutoLayout()
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DestinationHeader.self,
                           forHeaderFooterViewReuseIdentifier: DestinationHeader.identifier)
        tableView.register(DestinationCell.self, forCellReuseIdentifier: DestinationCell.identifier)
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        return tableView.toAutoLayout()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        interactor?.fetchDestinations()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        searchField.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(headerStack)
        headerStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().offset(10)
            make.height.equalTo(56)
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(105)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension DestinationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var search = textField.text!
        if let r = Range(range, in: search){
            search.removeSubrange(r) // it will delete any deleted string.
        }
        search.insert(contentsOf: string, at: search.index(search.startIndex, offsetBy: range.location)) // it will insert any text.
        interactor?.filterDestinations(using: search)
        return true
    }
}

extension DestinationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DestinationCell.identifier, for: indexPath) as? DestinationCell,
              let destination = dataSource[safe: indexPath.row] else { return UITableViewCell() }
        cell.title = "\(destination.name), \(destination.countryName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DestinationHeader.identifier) as? DestinationHeader else { return UITableViewHeaderFooterView() }
        header.title = "Популярные направления"
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource[indexPath.row]
        interactor?.didChooseDestination(destination: item)
        dismiss(animated: true)
    }
}
