import UIKit
import SnapKit

protocol FindToursDisplayLogic where Self: AnyObject {
    func showError(error: ValidationError)
    func proceed(using query: SearchQuery)
    func showDestination(place: Destination)
}

extension FindToursViewController: FindToursDisplayLogic {
    @MainActor
    func showError(error: ValidationError) {
        fromField.errorMessage = error.localizedDescription
    }
    
    @MainActor
    func proceed(using query: SearchQuery) {
        router?.navigateToSearch(using: query)
    }
    
    @MainActor
    func showDestination(place: Destination) {
        fromField.errorMessage = nil
        fromField.text = "\(place.name), \(place.countryName)"
    }
}

class FindToursViewController: UIViewController {
    var interactor: FindToursBusinessLogic?
    var router: FindToursRoutingLogic?
    
    private lazy var findButton: UIButton = {
        let button = UIButton()
        button.setTitle("Найти тур", for: .normal)
        button.backgroundColor = AppColor.buttonBackground
        button.layer.cornerRadius = 18
        button.addAction {
            self.interactor?.validate()
        }
        return button.toAutoLayout()
    }()
    
    private var fromField: SkyFloatingLabelTextField = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "Откуда"
        field.title = "Откуда"
        field.returnKeyType = .route
        return field.toAutoLayout()
    }()
    
    private var destinationField: SkyFloatingLabelTextField = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "Куда"
        field.text = "Доминикана"
        field.returnKeyType = .route
        field.isUserInteractionEnabled = false
        return field.toAutoLayout()
    }()
    
    private lazy var tripStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(fromField)
        stack.addArrangedSubview(Separator())
        stack.addArrangedSubview(destinationField)
        return stack.toAutoLayout()
    }()
    
    private var tripView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = AppColor.elementBackground
        
        return view.toAutoLayout()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Поиск туров"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configure()
    }
    
    private func configure() {
        view.addSubview(findButton)
        findButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(60)
        }
        
        view.addSubview(tripView)
        tripView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        tripView.addSubview(tripStack)
        tripStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
        tripStack.subviews.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
        
        fromField.addTarget(self, action:#selector(textDidBeginEditing), for: UIControl.Event.editingDidBegin)
    }
    
    @objc
    func textDidBeginEditing(sender: UITextField) -> Void {
        sender.resignFirstResponder()
        router?.navigateToDestinationsScene { [weak self] destination in
            self?.interactor?.setDestination(where: destination)
        }
    }
    
}

