import UIKit

final class PusheenFountainFirework: FountainFirework {

    override var sparkViewFactory: SparkViewFactory {
        return PusheenSparkViewFactory()
    }
}
