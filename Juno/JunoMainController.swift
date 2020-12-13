//
//  BaseButtonViewController.swift
//  Juno
//
//  Created by Emre Onder on 13.12.2020.
//

import Foundation
import UIKit

class JunoMainController: UIViewController {

    private(set) var consoleButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        window.windowLevel = UIWindow.Level(rawValue: CGFloat.greatestFiniteMagnitude)
        window.isHidden = false
        window.rootViewController = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(note:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    private let window = ButtonWindow()

    override func loadView() {
        let view = UIView()
        let button = UIButton(type: .custom)
        button.setTitle("Console", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize.zero
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.sizeToFit()
        button.frame = CGRect(origin: CGPoint(x: 10, y: 10), size: button.bounds.size)
        button.autoresizingMask = []
        button.addTarget(self, action: #selector(consoleButtonTapped), for: .touchUpInside)

        view.addSubview(button)
        self.view = view
        self.consoleButton = button
        window.button = button

        let panner = UIPanGestureRecognizer(target: self, action: #selector(panDidFire(panner:)))
        button.addGestureRecognizer(panner)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        snapButtonToSocket()
    }

    @objc private func consoleButtonTapped() {
        let consoleLogViewController = ConsoleViewController()
        consoleLogViewController.onClose = { [weak self] in
            self?.consoleButton.isHidden = false
        }
        let navigationController = UINavigationController(rootViewController: consoleLogViewController)
        self.consoleButton.isHidden = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func panDidFire(panner: UIPanGestureRecognizer) {
        let offset = panner.translation(in: view)
        panner.setTranslation(CGPoint.zero, in: view)
        var center = consoleButton.center
        center.x += offset.x
        center.y += offset.y
        consoleButton.center = center

        if panner.state == .ended || panner.state == .cancelled {
            UIView.animate(withDuration: 0.3) {
                self.snapButtonToSocket()
            }
        }
    }

    @objc private func keyboardDidShow(note: NSNotification) {
        window.windowLevel = UIWindow.Level(rawValue: 0)
        window.windowLevel = UIWindow.Level(rawValue: CGFloat.greatestFiniteMagnitude)
    }

    private func snapButtonToSocket() {
        var bestSocket = CGPoint.zero
        var distanceToBestSocket = CGFloat.infinity
        let center = consoleButton.center
        for socket in sockets {
            let distance = hypot(center.x - socket.x, center.y - socket.y)
            if distance < distanceToBestSocket {
                distanceToBestSocket = distance
                bestSocket = socket
            }
        }
        consoleButton.center = bestSocket
    }

    private var sockets: [CGPoint] {
        let topSafeArea = view.safeAreaInsets.top
        let buttonSize = consoleButton.bounds.size
        let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2 + topSafeArea)
        let sockets: [CGPoint] = [
            CGPoint(x: rect.minX, y: rect.minY),
            CGPoint(x: rect.minX, y: rect.maxY),
            CGPoint(x: rect.maxX, y: rect.minY),
            CGPoint(x: rect.maxX, y: rect.maxY),
            CGPoint(x: rect.midX, y: rect.midY)
        ]
        return sockets
    }

}

private class ButtonWindow: UIWindow {

    var button: UIButton?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    fileprivate override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard rootViewController?.presentedViewController == nil else { return true }
        guard let button = button else { return false }
        let buttonPoint = convert(point, to: button)
        return button.point(inside: buttonPoint, with: event)
    }

}
