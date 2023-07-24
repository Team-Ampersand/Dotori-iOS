import Anim
import UIKit

struct ModalAnim: Anim {
    func animate(view: UIView, completion: @escaping () -> Void) {
        let scaleAffineTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        let transformFrom = view.transform
        let transformTo = view.transform.concatenating(scaleAffineTransform)
        UIView.performWithoutAnimation {
            view.transform = transformTo
        }

        let springTimingParameters = UISpringTimingParameters(
            mass: 0.2,
            stiffness: 98.4,
            damping: 4.95,
            initialVelocity: .init(dx: 0, dy: 0)
        )
        let animator = UIViewPropertyAnimator(duration: 0.2, timingParameters: springTimingParameters)
        animator.addAnimations {
            view.transform = transformFrom
        }
        animator.addCompletion { _ in
            completion()
        }
        animator.startAnimation()
    }
}
