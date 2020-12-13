//
//  Logger.swift
//  Juno
//
//  Created by Emre Onder on 13.12.2020.
//

import Foundation

class Logger {
    
    typealias VoidHandler = () -> Void
    
    static let instance = Logger()
    
    var logs: [String] = []
    private let outputPipe = Pipe()
    private let queue = DispatchQueue(label: "logger.array.queue")

    init() {}
    

    func clearLogs(completion: VoidHandler?) {
        queue.async {
            self.logs.removeAll()
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
    func addLog(log: String) {
        queue.async {
            self.logs.insert(log, at: 0)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(NSNotification.Name.NSFileHandleDataAvailable)
    }
    
}
