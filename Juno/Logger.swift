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
    
    // Use this function to catch prints inside same framework. It doesn't work If print run on different module.
    func catchLogs() {
        dup2(self.outputPipe.fileHandleForWriting.fileDescriptor, FileHandle.standardOutput.fileDescriptor)
        
        outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable, object: outputPipe.fileHandleForReading , queue: nil) {
            notification in
            
            let output = self.outputPipe.fileHandleForReading.availableData
            let outputString = String(data: output, encoding: String.Encoding.utf8) ?? ""
            self.addLog(log: outputString)
            self.outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(NSNotification.Name.NSFileHandleDataAvailable)
    }
    
}
