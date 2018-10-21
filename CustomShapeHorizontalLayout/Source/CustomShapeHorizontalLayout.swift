//
//  CustomShapeHorizontalLayout.swift
//  CustomShapeHorizontalLayout
//
//  Created by Luis  Costa on 21/10/2018.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

public protocol HorizontalLayoutProtocol: class {
    var portraitWidth: CGFloat { get }
    var lanscapeWidth: CGFloat { get }
    var squareWidth: CGFloat { get }
    var cellPadding: CGFloat { get }
    
    func collectionView(_ collectionView: UICollectionView, itemOrientationAt indexpath: IndexPath) -> CustomShapeHorizontalLayout.Orientation
}

public class CustomShapeHorizontalLayout: UICollectionViewLayout {
    public weak var delegate: HorizontalLayoutProtocol?
    
    // Number of Lines
    fileprivate var numberOfRows: Int = 2
    // CollectionVieewLayoutAttributes Cache
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    // Content Height
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.height - insets.top - insets.bottom
    }
    
    // Content Width
    fileprivate var contentWidth: CGFloat = 0
    
    // CollectionView ContentSize
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - Override Functions
    override public func prepare() {
        guard cache.isEmpty, let collectionView = self.collectionView, let delegate = delegate else {
            return
        }
        
        // Reset content width
        contentWidth = 0
        
        let columnHeight = contentHeight / CGFloat(numberOfRows)
        
        // Variables to save the last X offset
        var lastOffset: CGFloat = 0
        
        // Array containing Y offset
        var yOffset =  [CGFloat]()
        (0 ..< numberOfRows).forEach({ yOffset.append(CGFloat($0) * columnHeight) })
        
        // Array containing X offset
        var row: Int = 0
        var xOffset = [CGFloat](repeating: 0, count: numberOfRows)
        
        // Loop through number of items in collection view
        (0 ..< collectionView.numberOfItems(inSection: 0)).forEach { item in
            let indexPath = IndexPath(item: item, section: 0)
            
            // Get orientation on image
            let orientation = delegate.collectionView(collectionView, itemOrientationAt: indexPath)
            
            var width: CGFloat {
                // Returns cell width depending image orientation
                switch orientation {
                case .square: return delegate.squareWidth
                case .landscape: return delegate.lanscapeWidth
                case .portrait: return delegate.portraitWidth
                }
            }
            
            var height: CGFloat {
                switch orientation {
                case .landscape, .square: return columnHeight // Half of Collection View Content Height
                case .portrait: return columnHeight * 2 // Colelction View Content Height
                }
            }
            
            var xOrigin: CGFloat {
                guard orientation == .portrait else { return xOffset[row] }
                return lastOffset
            }
            
            var yOrigin: CGFloat {
                guard orientation == .portrait else { return yOffset[row] }
                return yOffset[0]
            }
            
            let frame = CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
            let insetFrame = frame.insetBy(dx: delegate.cellPadding, dy: delegate.cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // Update CollectionView content width
            contentWidth = max(contentWidth, frame.maxX)
            
            if orientation == .portrait {
                xOffset[0] = lastOffset + width
                xOffset[1] = lastOffset + width
            }
            else {
                xOffset[row] += width
            }
            
            lastOffset = xOffset[row] > lastOffset ? xOffset[row] : lastOffset
            
            row = row < numberOfRows - 1 ? row + 1 : 0
            
            // If it is portrait next attributes must have row = 0
            if orientation == .portrait { row = 0 }
        }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Check which frame attributes intersects the received rect
        return cache.filter({ $0.frame.intersects(rect) })
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override public func invalidateLayout() {
        super.invalidateLayout()
        cache = []
    }
}

public extension CustomShapeHorizontalLayout {
    public enum Orientation: CaseIterable {
        case portrait
        case landscape
        case square
    }
}
