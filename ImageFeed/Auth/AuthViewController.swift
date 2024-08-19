import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ viewController: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    private let showWebViewSegueIdentifier = "ShowWebView"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    weak var delegate: AuthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard let webViewController = segue.destination as? WebViewController else {
                preconditionFailure("Error: \(showWebViewSegueIdentifier)")
            }
            webViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
    
extension AuthViewController: WebViewControllerDelegate {
    func webViewController(_ viewController: WebViewController, didAuthenticateCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewControllerDidCancel(_ viewController: WebViewController) {
        dismiss(animated: true)
    }
}
