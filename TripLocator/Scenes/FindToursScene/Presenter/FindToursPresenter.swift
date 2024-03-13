import Foundation

protocol FindToursPresentationLogic where Self: AnyObject {
    func presentError(error: ValidationError)
    func proceed(using data: SearchQuery)
    func presentDestination(place: Destination)
}

final class FindToursPresenter: FindToursPresentationLogic {
    weak var view: FindToursDisplayLogic?
    
    func presentError(error: ValidationError) {
        view?.showError(error: error)
    }
    
    func proceed(using data: SearchQuery) {
        view?.proceed(using: data)
    }
    
    func presentDestination(place: Destination) {
        view?.showDestination(place: place)
    }
}

