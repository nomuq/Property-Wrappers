@propertyWrapper
struct Demo {
    var xo: String
    var wrappedValue: String
    var projectedValue: String

    init(){
        print("wrapperinitcalled")
        self.xo = "xo"
        self.wrappedValue = "wrappedvalue"
        self.projectedValue = "projectedValue"
    }

}



@propertyWrapper
class Scrollable{
    var wrappedValue: UIView
    var projectedValue: ScrollView

    public init(Direction direction: ScrollView.Direction) {
        self.wrappedValue = UIView()
        self.projectedValue = ScrollView(with: direction)
        self.wrappedValue = projectedValue.container
    }
}

class UIView{}
class UIScrollView{}
class ScrollView {
    // MARK: - Attributes -
    /// Scroll View Scroll Direction
    ///
    /// - vertical: Vertical Scroll
    /// - horizontal: Horizontal Scroll
    /// - all: Scroll in Both Direction ( Vertical + Horizontal )
    internal enum Direction {
        case vertical
        case horizontal
        case all
    }

    /// Scroll Container View
    public var container: UIView!

    /// Scroll Direction
    fileprivate var direction: Direction = .vertical

    // MARK: - Lifecycle -
    init(with direction: Direction = .vertical) {
        print(#function)
        self.direction = direction
        setupView()
        setupLayout()
    }

    // MARK: - Initializations -
    func setupView() {
       print(#function)
       container = UIView()
    }

    // MARK: - Layout -
    func setupLayout() {
        print(#function)
    }
}



@propertyWrapper
public struct Lazy<Value> {

    var storage: Value?
    let constructor: () -> Value

    /// Creates a lazy property with the closure to be executed to provide an initial value once the wrapped property is first accessed.
    ///
    /// This constructor is automatically used when assigning the initial value of the property, so simply use:
    ///
    ///     @Lazy var text = "Hello, World!"
    ///
    public init(wrappedValue constructor: @autoclosure @escaping () -> Value) {
        self.constructor = constructor
        print("init")
    }

    public var wrappedValue: Value {
        mutating get {
            if storage == nil {
                self.storage = constructor()
            }
            print("get")
            return storage!
        }
        set {
            print("set")
            storage = newValue
        }
    }

    // MARK: Utils

    /// Resets the wrapper to its initial state. The wrapped property will be initialized on next read access.
    public mutating func reset() {
        storage = nil
    }
}

class Dex{
    // @Demo var x : String
    // @Scrollable(Direction: .vertical) var y: UIView
    @Lazy var result = UIView()

    init(){
        print("init called")
    }
}
let dex = Dex()
// print(dex.y)
// print(dex.$y)
print(dex.result)
