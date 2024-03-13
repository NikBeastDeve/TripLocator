import Foundation

protocol ToursBusinessLogic where Self: AnyObject {
    func startSearch()
}

final class ToursInteractor: ToursBusinessLogic {
    var presenter: ToursPresentationLogic?
    var worker: ToursWorkerProtocol?
    
    private let query: SearchQuery
    private var searchId: String?
    
    init(query: SearchQuery) {
        self.query = query
    }
    
    func startSearch() {
        presenter?.presentLoading()
        worker?.startSearch(query: query) { [weak self] result in
            switch result {
            case .success(let success):
                self?.searchId = success.key
                self?.checkSearch()
            case .failure(let failure):
                self?.presenter?.presentError(error: failure)
            }
        }
    }
    
    func checkSearch() {
        guard let searchId else { return }
        worker?.checkSearch(id: searchId) { [weak self] result in
            switch result {
            case .success(let success):
                // check for an error in search
                if let error = success.error {
                    self?.presenter?.presentError(error: .requestError)
                    return
                }
                
                if success.status != "success" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { self?.checkSearch() } )
                } else {
                    self?.fetchFinalSearch()
                }
            case .failure(let failure):
                self?.presenter?.presentError(error: failure)
            }
        }
    }
    
    func fetchFinalSearch() {
        guard let searchId else { return }
        
        worker?.fetchSearchResults(id: searchId) { [weak self] result in
            switch result {
            case .success(let success):
                guard let offers = success.offers else { self?.presenter?.presentError(error: .requestError); return }
                self?.presenter?.presentResults(offers: offers)
            case .failure(let failure):
                self?.presenter?.presentError(error: failure)
            }
        }
    }
}
