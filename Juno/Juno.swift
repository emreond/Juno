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
    }
    
    public static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
        Logger.instance.addLog(log: output)
    }
    
    public static func print(_ items: String..., filename: String = #file, function : String = #function, line: Int = #line, separator: String = " ", terminator: String = "\n") {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
        Logger.instance.addLog(log: output)
    }
    
}
