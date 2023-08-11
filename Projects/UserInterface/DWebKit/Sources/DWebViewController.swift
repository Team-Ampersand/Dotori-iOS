import UIKit
import WebKit

public final class DWebViewController: UIViewController, WKNavigationDelegate {
    // MARK: - Properties
    private let urlString: String
    private let wkWebView: WKWebView
    private let detectKeyword: String
    private let detectHandler: () -> Void
    private var urlObservation: NSKeyValueObservation?

    // MARK: - Init
    public init(
        urlString: String,
        tokenDTO: LocalStorageTokenDTO? = nil,
        detectKeyword: String = "signin",
        detectHandler: @escaping () -> Void = {}
    ) {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true

        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences = preferences

        let wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        self.wkWebView = wkWebView
        self.urlString = urlString
        self.detectKeyword = detectKeyword
        self.detectHandler = detectHandler
        super.init(nibName: nil, bundle: nil)
        if let tokenDTO {
            setAccessToken(tokenDTO: tokenDTO, configuration: wkWebView.configuration)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(wkWebView)
        NSLayoutConstraint.activate([
            wkWebView.topAnchor.constraint(equalTo: view.topAnchor),
            wkWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wkWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wkWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        wkWebView.navigationDelegate = self
        wkWebView.allowsBackForwardNavigationGestures = true
        wkWebView.allowsLinkPreview = true
        DispatchQueue.main.async {
            guard let url = URL(string: self.urlString) else { return }
            let request = URLRequest(url: url)
            self.wkWebView.load(request)
        }
        urlObservation = wkWebView.observe(\.url, options: .new) { [detectKeyword, detectHandler] webView, _ in
            guard let url = webView.url?.absoluteString, url.contains(detectKeyword) else {
                return
            }
            detectHandler()
        }
    }
}

private extension DWebViewController {
    func setAccessToken(tokenDTO: LocalStorageTokenDTO, configuration: WKWebViewConfiguration) {
        let dataStore = WKWebsiteDataStore.default()
        let accessCookie = makeCookie(
            key: "Authorization",
            value: "Bearer%20\(tokenDTO.accessToken)",
            age: "10800"
        )
        dataStore.httpCookieStore.setCookie(accessCookie)
        let refreshCookie = makeCookie(
            key: "RefreshToken",
            value: "Bearer%20\(tokenDTO.refreshToken)",
            age: "604800"
        )
        dataStore.httpCookieStore.setCookie(refreshCookie)
        configuration.websiteDataStore = dataStore
    }

    func makeCookie(key: String, value: String, age: String) -> HTTPCookie {
        HTTPCookie(properties: [
            .domain: "www.dotori-gsm.com",
            .path: "/",
            .name: key,
            .value: value,
            .maximumAge: age
        ]) ?? .init()
    }
}
