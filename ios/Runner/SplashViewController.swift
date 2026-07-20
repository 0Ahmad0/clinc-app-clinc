import Flutter
import Lottie
import UIKit

final class SplashViewController: UIViewController {
  private var hasStarted = false
  private var hasOpenedFlutter = false

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard !hasStarted else { return }
    hasStarted = true
    loadAnimation()
  }

  private func loadAnimation() {
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      let animation = LottieAnimation.named("logo_animation", bundle: .main)

      DispatchQueue.main.async {
        guard let self, let animation else {
          self?.openFlutter()
          return
        }
        self.play(animation)
      }
    }
  }

  private func play(_ animation: LottieAnimation) {
    let animationView = LottieAnimationView(animation: animation)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .playOnce
    view.addSubview(animationView)

    NSLayoutConstraint.activate([
      animationView.widthAnchor.constraint(equalToConstant: 300),
      animationView.heightAnchor.constraint(equalToConstant: 300),
      animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])

    animationView.play { [weak self] _ in
      self?.openFlutter()
    }
  }

  private func openFlutter() {
    guard !hasOpenedFlutter, let window = view.window else { return }
    hasOpenedFlutter = true

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let flutterViewController = storyboard.instantiateViewController(
      withIdentifier: "FlutterViewController"
    )
    window.rootViewController = flutterViewController
  }
}
