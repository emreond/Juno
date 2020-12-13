//
//  Juno.swift
//  Juno
//
//  Created by Emre Onder on 13.12.2020.
//

import Foundation

public class Juno {
    
    private let mainController: JunoMainController
    
    @discardableResult
    public init() {
        mainController = JunoMainController()
        Logger.instance.catchLogs()
    }
    
}
