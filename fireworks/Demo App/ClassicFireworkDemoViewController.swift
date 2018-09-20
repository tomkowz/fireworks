import UIKit

final class ClassicFireworkDemoViewController: UIViewController {

    @IBOutlet private var label: UILabel!

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

    @IBOutlet private var btn3: UIButton! {
        didSet {
            self.btn3.tag = 2
            self.btn3.style()
        }
    }

    private var correctSolutionIndex: Int = 0

    private let fireworkController = ClassicFireworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
    }

    private func refresh() {
        let num1 = Int(arc4random_uniform(10))
        let num2 = Int(arc4random_uniform(10))

        let sol1 = num1 + num2
        var sol2 = sol1 + Int(arc4random_uniform(10)) - 5
        if sol2 == sol1 {
            sol2 += 1
        }

        var sol3 = sol1 + Int(arc4random_uniform(12)) - 4
        if sol3 == sol1 {
            sol3 -= 1
        }

        var solutions = [sol1, sol2, sol3]
        var shuffled = [Int]()

        for _ in 0..<solutions.count {
            let idx = Int(arc4random_uniform(UInt32(solutions.count)))
            shuffled.append(solutions[idx])
            solutions.remove(at: idx)
        }

        self.label.text = "\(num1) + \(num2) = ?"
        self.btn1.setTitle("\(shuffled[0])", for: .normal)
        self.btn2.setTitle("\(shuffled[1])", for: .normal)
        self.btn3.setTitle("\(shuffled[2])", for: .normal)
        self.correctSolutionIndex = shuffled.index(of: sol1)!
    }

    @IBAction private func btnTapped(sender: UIButton) {
        self.checkSolution(selection: sender.tag, correct: self.correctSolutionIndex, button: sender)

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

    private func checkSolution(selection: Int, correct: Int, button: UIButton) {
        guard selection == correct else { return }

        self.fireworkController.addFireworks(count: 2, sparks: 8, around: button)
        self.refresh()
    }
}

extension UIButton {

    func style() {
        let color = UIColor(red:0.42, green:0.58, blue:0.98, alpha:1.00)
        self.backgroundColor = color
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 8
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)

        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.3

        let shadowWidth = layer.bounds.width * 0.9
        let shadowRect = CGRect(x: 0 + (layer.bounds.width - shadowWidth) / 2.0, y: 0, width: shadowWidth, height: layer.bounds.height)
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath

        layer.zPosition = 2
    }
}
