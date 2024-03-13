import UIKit

extension UIViewController {
    
    func showTitleOkAlert(title: String,
                          okAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
            okAction?()
        }))
        topMostViewController().present(alertController, animated: true, completion: nil)
    }
    
    func showOkAlert(with title: String,
                     message: String,
                     okAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
            okAction?()
        }))
        topMostViewController().present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(with title: String,
                   message: String,
                   buttonTitle: String,
                   okAction: (() -> Void)? = nil,
                   perfomAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
            okAction?()
        }))
        alertController.addAction(UIAlertAction.init(title: buttonTitle, style: .default, handler: { (action) in
            perfomAction()
        }))
        topMostViewController().present(alertController, animated: true, completion: nil)
    }
    
    
    private func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        return self.presentedViewController!.topMostViewController()
    }
}
