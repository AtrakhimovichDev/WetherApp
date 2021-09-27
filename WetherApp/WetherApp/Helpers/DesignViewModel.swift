//
//  protocol.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation

protocol DesignViewModel {
    var designModel: DesignModel? { get set }
    var didUpdateDesignModel: ((DesignModel) -> Void)? { get set }
}
