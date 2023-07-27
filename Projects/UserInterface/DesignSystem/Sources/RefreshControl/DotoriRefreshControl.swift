import Lottie
import MSGLayout
import UIKit

public final class DotoriRefreshControl: UIRefreshControl {
    private let dotoriLoadingView = LottieAnimationView(
        animation: AnimationAsset.dotoriLoading.animation
    )

    public override init() {
        super.init()
        self.tintColor = .clear
        dotoriLoadingView.loopMode = .loop
        self.addSubviews {
            dotoriLoadingView
        }
        MSGLayout.buildLayout {
            dotoriLoadingView.layout
                .size(100)
                .center(.toSuperview())
        }
        dotoriLoadingView.play()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func beginRefreshing() {
        super.beginRefreshing()
        dotoriLoadingView.play()
    }
}
