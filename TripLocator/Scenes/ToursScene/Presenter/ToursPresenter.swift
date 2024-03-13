import Foundation

protocol ToursPresentationLogic where Self: AnyObject {
    func presentError(error: APIError)
    func presentResults(offers: [Offer])
    func presentLoading()
}

final class ToursPresenter: ToursPresentationLogic {
    weak var view: ToursDisplayLogic?
    
    func presentError(error: APIError) {
        view?.showError(error: error)
    }
    
    func presentResults(offers: [Offer]) {
        view?.showResults(offers: offers)
    }
    
    func presentLoading() {
        view?.showLoading()
    }
}
