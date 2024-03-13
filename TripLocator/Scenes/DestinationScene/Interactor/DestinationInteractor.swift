import Foundation

protocol DestinationBusinessLogic where Self: AnyObject {
    func fetchDestinations()
    func filterDestinations(using value: String)
    func didChooseDestination(destination: Destination)
}

final class DestinationInteractor: DestinationBusinessLogic {
    var presenter: DestinationPresentationLogic?
    var worker: DestinationWorkerProtocol?
    
    private var destinations: DestinationResponse = []
    private var callback: ((Destination) -> Void)?
    
    init(destinationCallback: ((Destination) -> Void)?) {
        callback = destinationCallback
    }
    
    func didChooseDestination(destination: Destination) {
        callback?(destination)
    }
    
    func fetchDestinations() {
        presenter?.presentLoading()
        
        worker?.getDestinations { [weak self] result in
            switch result {
            case let .success(data):
                self?.destinations = data
                self?.presenter?.presentDestinations(destinations: data)
            case let .failure(error):
                self?.presenter?.presentError(error: error)
            }
        }
    }
    
    func filterDestinations(using value: String) {
        if destinations.isEmpty { return }
        if value.isEmpty { presenter?.presentDestinations(destinations: destinations); return }
        
        let data = destinations.filter { $0.name.contains(value) }
        presenter?.presentDestinations(destinations: data)
    }
}
