import UIKit

protocol SparkViewFactoryData {

    var size: CGSize { get }
    var index: Int { get }
}

protocol SparkViewFactory {

    func create(with data: SparkViewFactoryData) -> SparkView
}

struct DefaultSparkViewFactoryData: SparkViewFactoryData {

    let size: CGSize
    let index: Int
}
