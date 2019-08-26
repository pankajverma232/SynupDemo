//
//  Extensions.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 24/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import UIKit

extension Int {
    var boolValue: Bool { return self != 0 }
    var stringValue:String { return "\(self)" }
}

extension String {

    var intValue:Int {return Int(self) ?? -1}
}

//MARK:- Table view
//will register the cell if nib name is same as the class name
extension UITableView{
    func register<T>(cell : T.Type) where T : ReuseIdentifier,T : UITableViewCell , T : NibLoadableView {
        register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    func dequeueReusableCell<T>(indexPath: IndexPath) -> T where T : UITableViewCell, T : ReuseIdentifier {
        guard  let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(type(of: self)) Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }
}

protocol ReuseIdentifier : class {
    
}
extension ReuseIdentifier where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView : class{
    
}
extension NibLoadableView where Self : UIView {
    static var nibName : String {
        return String(describing: self)
    }
    
}
