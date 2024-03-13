import Foundation
import UIKit

protocol SceneContruction: AnyObject {
    func makeFindToursScene() -> UIViewController
    func makeDestinationScene(destinationCallback: ((Destination) -> Void)?) -> UIViewController
    func makeToursScene(query item: SearchQuery) -> UIViewController
}

final class SceneFactory: SceneContruction {
    func makeFindToursScene() -> UIViewController {
        let vc = FindToursViewController()
        let interactor = FindToursInteractor()
        let presenter = FindToursPresenter()
        let router = FindToursRouter()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.view = vc
        router.view = vc
        
        return vc
    }
    
    func makeDestinationScene(destinationCallback: ((Destination) -> Void)?) -> UIViewController {
        let vc = DestinationViewController()
        let interactor = DestinationInteractor(destinationCallback: destinationCallback)
        let presenter = DestinationPresenter()
        let worker = DestinationWorker()
        
        vc.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.view = vc
        
        return vc
    }
    
    func makeToursScene(query item: SearchQuery) -> UIViewController {
        let vc = ToursViewController()
        let interactor = ToursInteractor(query: item)
        let presenter = ToursPresenter()
        let worker = ToursWorker()
        
        vc.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.view = vc
        
        return vc
    }
}
