//
//  ViewControllerMock.swift
//  ToDoTests
//
//  Created by kiranjith on 17/04/2025.
//

import UIKit

class ViewControllerMock: UIViewController {
    var lastPresented: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (()-> Void)? = nil) {
        lastPresented = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag,
                      completion: completion)
    }
}
