import UIKit

protocol WebViewControllerDelegate: AnyObject {
    func webViewController(_ viewController: WebViewController, didAuthenticateCode code: String)
    func webViewControllerDidCancel(_ viewController: WebViewController)
}

final class WebViewController: UIViewController {
    private enum WebConstants {
        static let authURLString = "https://unsplash.com/oauth/authorize"
        static let authURLPath = "/oauth/authorize/native"
        static let code = "code"
    }
    
    private enum WebElements {
      static let clientId = "client_id"
      static let redirectUri = "redirect_uri"
      static let responseType = "response_type"
      static let scope = "scope"
    }
    
    weak var delegate: WebViewControllerDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        setupProgress()
        setupUnsplashAuthWebView()
    }
}

extension WebViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        webView.removeObserver(
            self,       
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil
        )
        updateProgress()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}


private extension WebViewController {
    func setupUnsplashAuthWebView() {
        guard var urlComponents = URLComponents(string: WebConstants.authURLString) else {
            preconditionFailure("Incorrect \(WebConstants.authURLString) string")
        }
        urlComponents.queryItems = [
            URLQueryItem(name: WebElements.clientId, value: accessKey),
            URLQueryItem(name: WebElements.redirectUri, value: redirectURI),
            URLQueryItem(name: WebElements.responseType, value: WebConstants.code),
            URLQueryItem(name: WebElements.scope, value: accessScope)
        ]
        
        guard let url = urlComponents.url else {
            print(CancellationError())
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == WebConstants.authorizedURLPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == WebConstants.code }) {
            return codeItem.value
        } else {
            return nil
        }
    }
        
    func setupProgress() {
        progressView.progressTintColor = .ypBlack
        progressView.trackTintColor = .ypGray
        progressView.progressViewStyle = .bar
    }
    
    func updateProgress() {
      progressView.progress = Float(webView.estimatedProgress)
      progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = code(from: navigationAction) {
            delegate?.webViewController(self, didAuthenticateCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
}
