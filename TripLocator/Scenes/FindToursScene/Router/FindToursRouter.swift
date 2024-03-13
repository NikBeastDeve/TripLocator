import UIKit

protocol FindToursRoutingLogic where Self: AnyObject {
    func navigateToDestinationsScene(destinationCallback: ((Destination) -> Void)?)
    func navigateToSearch(using query: SearchQuery)
}

final class FindToursRouter: FindToursRoutingLogic {
    weak var view: UIViewController?
    private let sceneFactory: SceneContruction = SceneFactory()
    
    func navigateToDestinationsScene(destinationCallback: ((Destination) -> Void)?) {
        let vc = sceneFactory.makeDestinationScene(destinationCallback: destinationCallback)
        view?.present(vc, animated: true)
    }
    
    func navigateToSearch(using query: SearchQuery) {
        let vc = sceneFactory.makeToursScene(query: query)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
