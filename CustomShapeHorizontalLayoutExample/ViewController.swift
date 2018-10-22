//
//  ViewController.swift
//  CustomShapeHorizontalLayoutExample
//
//  Created by Luis  Costa on 21/10/2018.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit
import CustomShapeHorizontalLayout

class ViewController: UIViewController, UICollectionViewDataSource {
    
    // UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    let colors: [UIColor] = [.black, .blue, .green, .brown, .cyan, .darkGray, .yellow, .red, .green]
    let orientations = CustomShapeHorizontalLayout.Orientation.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        // Collection View Layout
        let layout = CustomShapeHorizontalLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
        layout.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 50 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let randomIndex = Int.random(in: 0 ..< colors.count)
        let color = colors[randomIndex]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = color
        return cell
    }
}

extension ViewController: HorizontalLayoutDelegate {
    var portraitWidth: CGFloat {
        return CGFloat(185)
    }
    
    var lanscapeWidth: CGFloat {
        return CGFloat(205)
    }
    
    var squareWidth: CGFloat {
        return CGFloat(135)
    }
    
    var cellPadding: CGFloat {
        return CGFloat(6)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemOrientationAt indexpath: IndexPath) -> CustomShapeHorizontalLayout.Orientation {
        let randomIndex = Int.random(in: 0 ..< orientations.count)
        return orientations[randomIndex]
    }
}
