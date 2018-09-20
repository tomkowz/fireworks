import UIKit

final class FountainFireworkDemoViewController: UIViewController {

    @IBOutlet private var label: UILabel! {
        didSet { self.label.text = "" }
    }

    @IBOutlet private var btn1: UIButton! {
        didSet {
            self.btn1.tag = 0
            self.btn1.style()
        }
    }

    @IBOutlet private var btn2: UIButton! {
        didSet {
            self.btn2.tag = 1
            self.btn2.style()
        }
    }

    private var fireworksController = FountainFireworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
    }

    private func refresh() {
        let num1 = Int(arc4random_uniform(10))
        let num2 = Int(arc4random_uniform(10))

        self.btn1.setTitle("\(num1)", for: .normal)
        self.btn2.setTitle("\(num2)", for: .normal)
    }

    @IBAction private func btnTapped(sender: UIButton) {
        self.label.text = sender.titleLabel?.text

        self.fireworksController.addFirework(sparks: 10, above: self.label)
        self.refresh()

        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    @IBAction private func buttonTouchedDown(sender: UIButton) {
        UIView.animate(withDuration: 0.05, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.92)
        }, completion: nil)
    }

    @IBAction private func buttonTouchedUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
