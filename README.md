# CustomShapeHorizontalLayout
A CollectionViewLayout that enables horizontal scroll using cells with different aspect ratios. :camera: :sunrise:


## Requirements
* ARC
* iOS 8.0

### Installation
CustomShapeHorizontalLayout is available through [CocoaPods](https://cocoapods.org)<br/>
```ruby
pod 'CustomShapeHorizontalLayout', :git => "https://github.com/lmbcosta/CustomShapeHorizontalLayout.git"
```

## Usage
#### Import 
Like other CocoaPods you need the import CustomShapeHorizontalLayout

```swift
import CustomShapeHorizontalLayout
```

#### Protocol
After that, you need to supply a concrete implementation of HorizontalLayoutDelegate protocol.<br/>
```swift
public protocol HorizontalLayoutDelegate: class {
    var portraitWidth: CGFloat { get }
    var lanscapeWidth: CGFloat { get }
    var squareWidth: CGFloat { get }
    var cellPadding: CGFloat { get }
    
    func collectionView(_ collectionView: UICollectionView, itemOrientationAt indexpath: IndexPath) -> CustomShapeHorizontalLayout.Orientation
}

class MyViewController: UIViewController, HorizontalLayoutDelegate {

    var customShapeHorizontalLayout: CustomShapeHorizontalLayout?

    override func viewDidLoad() {
        super.viewDidLoad()
        customShapeHorizontalLayout?.delegate = self
    }

    var portraitWidth: CGFloat { return CGFloat(185) }
    
    var lanscapeWidth: CGFloat { return CGFloat(205) }
    
    var squareWidth: CGFloat { return CGFloat(135) }
    
    var cellPadding: CGFloat { return CGFloat(6) }
    
    func collectionView(_ collectionView: UICollectionView, itemOrientationAt indexpath: IndexPath) -> CustomShapeHorizontalLayout.Orientation {
        let orientations = CustomShapeHorizontalLayout.Orientation.allCases
        let randomIndex = Int.random(in: 0 ..< orientations.count)
        return orientations[randomIndex]
    }
}

```


<p>And you are ready to go:sunglasses:<p/>

<p>At the moment CustomShapeHorizontalLayout only supports 3 types of aspact ratio: Landscape, portrait and square.</p>

You can see a simple implementation of CustomShapeHorizontalLayout in [CustomShapeHorizontalLayoutExample](https://github.com/lmbcosta/CustomShapeHorizontalLayout/tree/master/CustomShapeHorizontalLayoutExample).
Please check [ViewController.swift](https://github.com/lmbcosta/CustomShapeHorizontalLayout/blob/master/CustomShapeHorizontalLayoutExample/ViewController.swift) file.</br>

## Author
Luís Costa - lmbcosta@hotmail.com<br/>

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/lmbcosta/TextFieldSequenceFormatterManager/blob/master/LICENCE) file for details


