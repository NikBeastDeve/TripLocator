import Foundation

enum ValidationError {
    case empty
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .empty:
            return NSLocalizedString("Field cannot be empty", comment: "ValidationError")
        }
    }
}

protocol FindToursBusinessLogic where Self: AnyObject {
    func validate()
    func setDestination(where data: Destination)
}

final class FindToursInteractor: FindToursBusinessLogic {
    var presenter: FindToursPresentationLogic?
    
    private var destination: Destination?
    
    init(presenter: FindToursPresentationLogic? = nil) {
        self.presenter = presenter
    }
    
    func setDestination(where data: Destination) {
        destination = data
        presenter?.presentDestination(place: data)
    }
    
    func validate() {
        guard let destination else { presenter?.presentError(error: .empty); return }
        proceedWithSearch(using: destination)
    }
    
    private func proceedWithSearch(using destination: Destination) {
        let search = Search(departCityID: 20001,//destination.countryID,
                            regionIDS: [2],//destination.pathIDS,
                            startFrom: "2024-09-15",
                            startTo: "2024-09-30",
                            durationFrom: 15,
                            durationTo: 30,
                            adults: 2)
        let query = SearchQuery(search: search)
        
        presenter?.proceed(using: query)
    }
}
