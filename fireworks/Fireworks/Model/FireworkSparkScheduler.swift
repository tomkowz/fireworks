import UIKit

public class FireworkSparkScheduler {

    public var delay: TimeInterval = 0.05
    private var timer: Timer?
    private var queue = [Data]()
    
    private struct Data {

        weak var presenterView: UIView?
        let sparks: [FireworkSpark]
        let animator: SparkViewAnimator
        let animationDuration: TimeInterval
    }

    public func schedule(sparks: [FireworkSpark],
                  in presenterView: UIView,
                  with animator: SparkViewAnimator,
                  animationDuration: TimeInterval) {
        let data = Data(presenterView: presenterView,
                        sparks: sparks,
                        animator: animator,
                        animationDuration: animationDuration)
                        
        self.queue.append(data)

        if self.timer == nil {
            self.scheduleTimer()
        }
    }

    public func cancel() {
        self.timer?.invalidate()
        self.timer = nil
    }

    private func scheduleTimer() {
        self.cancel()

        self.timer = Timer.scheduledTimer(timeInterval: self.delay,
                                          target: self,
                                          selector: #selector(timerDidFire),
                                          userInfo: nil, repeats: false)
    }

    @objc private func timerDidFire() {
        guard let data = self.queue.first else {
            self.cancel()
            return
        }

        guard let presenterView = data.presenterView else {
            self.cancel()
            return
        }

        for spark in data.sparks {
            presenterView.addSubview(spark.sparkView)
            data.animator.animate(spark: spark, duration: data.animationDuration)
        }

        self.queue.remove(at: 0)

        if self.queue.isEmpty {
            self.cancel()
        } else {
            self.scheduleTimer()
        }
    }
}
