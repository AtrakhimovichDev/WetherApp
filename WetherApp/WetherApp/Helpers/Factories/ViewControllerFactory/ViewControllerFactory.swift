//
//  ViewControllerFactory.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import UIKit

class ViewControllerFactory: NSObject {
    static func viewController(for typeOfVC: TypeOfViewController) -> UIViewController {
         let metadata = typeOfVC.storyboardRepresentation()
         let storyboard = UIStoryboard(name: metadata.storyboardName, bundle: metadata.bundle)
         let viewController = storyboard.instantiateViewController(withIdentifier: metadata.storyboardId)
         return viewController
     }
}
