import UIKit

public protocol SparkViewFactoryData {

    var size: CGSize { get }
    var index: Int { get }
}

public protocol SparkViewFactory {

    func create(with data: SparkViewFactoryData) -> SparkView
}

public struct DefaultSparkViewFactoryData: SparkViewFactoryData {

    public let size: CGSize
    public let index: Int
}
