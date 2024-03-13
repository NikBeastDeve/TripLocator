import Foundation
import UIKit

protocol DestinationPresentationLogic where Self: AnyObject {
    func presentDestinations(destinations: DestinationResponse)
    func presentError(error: APIError)
    func presentLoading()
}

final class DestinationPresenter: DestinationPresentationLogic {
    weak var view: DestinationDisplayLogic?
    
    func presentDestinations(destinations: DestinationResponse) {
        view?.showDestinations(destinations: destinations)
    }
    
    func presentError(error: APIError) {
        view?.showError(error: error)
    }
    
    func presentLoading() {
        view?.showLoading()
    }
}
