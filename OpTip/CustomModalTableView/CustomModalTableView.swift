//
//  CustomModalTableView.swift
//  GRAiTS
//
//  Created by yusuf terzi on 21.10.2020.
//  Copyright © 2020 Raxar Corporation. All rights reserved.
//

import UIKit

class CustomModalTableView: UIView, UIGestureRecognizerDelegate {
    private let panView = UIView()
    private let grayView = UIView()
    private let grayViewSecondPart = UIView()
    private let panViewImage = UIImageView()
    private let titleLabel = UILabel()
    private var startPosition: CGPoint!
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        button.setImage(UIImage(named: "CloseGray"), for: .normal)
        button.addTarget(self, action: #selector(self.closePressed(_:)), for: .touchUpInside)

        return button
    } ()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        button.setTitle("Share", for: .normal)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action: #selector(self.sharePressed(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    } ()
    
    private var lastchangeArray: [CGFloat] = .init()
    var heightConst: NSLayoutConstraint?
    var gestureDidStart: Bool = false
    let tableView = UITableView()
    
    var viewModel: CustomModalTableViewModel = CustomModalTableViewModel()

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            if gestureDidStart {
                  return true
            }
        }

        return false
    }
    
    open func loadData() {
        
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
           let velocity = panGesture.velocity(in: self)
            let location = panGesture.location(in: self)
            if location.y < panView.frame.height {
                return true
            }

            if velocity.y > 0 && tableView.contentOffset.y == 0 {
                    gestureDidStart = true
                  return true
            }
        }
              
        return false
    }
    
    func loadUI(baseController: UIViewController) {
        clipsToBounds = false
        layer.cornerRadius = 25
        //layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        if viewModel.hasShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset = .zero
            layer.shadowRadius = 25
        }
        
        panViewUI()
        if viewModel.hasGrayEffect {
            grayViewUI(baseController)
        }
        
        panViewImageUI()
        if viewModel.hasCloseButton {
            setupCloseButton()
        }
        if viewModel.hasTitle {
            panTitleViewUI()
        }
        tableViewUI(baseController)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewDidDrag(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
        
        heightConst = heightAnchor.constraint(equalToConstant: 0)
        heightConst?.isActive = true
        superview?.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.heightConst?.constant = self?.viewModel.originalHeight ?? 0
            self?.superview?.layoutIfNeeded()
        }
        
        backgroundColor = .white
        
    }
    
    func grayViewUI(_ baseController: UIViewController) {
        let tabBarHeight = baseController.tabBarController?.tabBar.frame.size.height ?? 0

        let barHeight =  (baseController.navigationController?.view.frame.height ?? 0.0) - viewModel.originalHeight - tabBarHeight
        baseController.navigationController?.view.addSubview(grayView)
        if let nav = baseController.navigationController?.view {
            grayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
            grayView.translatesAutoresizingMaskIntoConstraints = false
            grayView.topAnchor.constraint(equalTo: nav.topAnchor, constant: 0).isActive = true
            grayView.rightAnchor.constraint(equalTo: nav.rightAnchor, constant: 0).isActive = true
            grayView.leftAnchor.constraint(equalTo: nav.leftAnchor, constant: 0).isActive = true
            grayView.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            grayView.addGestureRecognizer(tap)
        }
        baseController.view.insertSubview(grayViewSecondPart, belowSubview: self)

        grayViewSecondPart.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        grayViewSecondPart.translatesAutoresizingMaskIntoConstraints = false
        grayViewSecondPart.bottomAnchor.constraint(equalTo: baseController.view.bottomAnchor, constant: tabBarHeight * -1).isActive = true
        grayViewSecondPart.rightAnchor.constraint(equalTo: baseController.view.rightAnchor, constant: 0).isActive = true
        grayViewSecondPart.leftAnchor.constraint(equalTo: baseController.view.leftAnchor, constant: 0).isActive = true
        grayViewSecondPart.heightAnchor.constraint(equalToConstant: viewModel.originalHeight).isActive = true
    }
    
    func tableViewUI(_ baseController: UIViewController) {
        self.addSubview(tableView)
        self.addSubview(shareButton)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: panView.bottomAnchor, constant: 32).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -16).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        tableView.isUserInteractionEnabled = false
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0);

        tableView.layer.cornerRadius = 5
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(red: 0.921, green: 0.94, blue: 1, alpha: 1).cgColor
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        shareButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.register(UINib(nibName: "LineCell", bundle: nil), forCellReuseIdentifier: "LineCell")
        tableView.register(UINib(nibName: "TipItemCell", bundle: nil), forCellReuseIdentifier: "TipItemCell")
    }
    
    func panViewUI() {
        addSubview(panView)
        panView.translatesAutoresizingMaskIntoConstraints = false
        panView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        panView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        panView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        panView.heightAnchor.constraint(equalToConstant: viewModel.panViewHeight).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        panView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if viewModel.hasMoreState {
            if viewModel.state == viewModel.bigState {
                viewModel.state = viewModel.minimalState
            } else {
                viewModel.state = viewModel.bigState
            }
            animationToOriginalHeight()
        } else {
            closeView()
        }
    }
    
    func animationToOriginalHeight() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.heightConst?.constant = self?.viewModel.originalHeight ?? 0
            self?.superview?.layoutIfNeeded()
        }
    }
    
    func panViewImageUI() {
        panView.addSubview(panViewImage)
        panViewImage.translatesAutoresizingMaskIntoConstraints = false
        panViewImage.heightAnchor.constraint(equalToConstant: 5).isActive = true
        panViewImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        panViewImage.topAnchor.constraint(equalTo: panView.topAnchor, constant: 10).isActive = true
        panViewImage.centerXAnchor.constraint(equalTo: panView.centerXAnchor, constant: 0).isActive = true
        panViewImage.contentMode = .scaleAspectFit
        panViewImage.image = UIImage(named: "indicator")
    }
    
    func panTitleViewUI() {
        panView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: panViewImage.topAnchor, constant: 14).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: panView.leftAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: panView.rightAnchor, constant: -16).isActive = true
        titleLabel.font = UIFont(name: "NunitoSans-SemiBold", size: 20)
        titleLabel.text = "Sort"
    }
    
    func setupCloseButton() {
        panView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: panView.topAnchor, constant: 10).isActive = true
        closeButton.rightAnchor.constraint(equalTo: panView.rightAnchor, constant: -10).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.setTitle("", for: .normal)
    }
    
    @objc func closePressed(_ sender: UIButton!) {
        closeView()
    }
    
    @objc func sharePressed(_ sender: UIButton!) {
        let image = tableView.asImage()
        closeView()
        viewModel.imageShareHandler?(image)
    }
    
    @objc private func viewDidDrag(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            startPosition = sender.location(in: self)
//            viewModel.originalHeight = heightConst?.constant ?? 0
        }

        if sender.state == .changed {
            let endPosition = sender.location(in: self)
            let difference = endPosition.y - startPosition.y
            var newHeight = (heightConst?.constant ?? 0) - difference
            lastchangeArray.append(difference)
            if lastchangeArray.count > 4 {
                lastchangeArray.remove(at: 0)
            }
            if viewModel.state == .big(Float(viewModel.originalHeight)) {
                if newHeight > viewModel.originalHeight {
                    newHeight = viewModel.originalHeight
                }
            } else {
                if newHeight > viewModel.bigState.height {
                    newHeight = viewModel.originalHeight
                }
            }
            
            heightConst?.constant = newHeight
        }

        if sender.state == .ended || sender.state == .cancelled {
            gestureDidStart = false
            if (heightConst?.constant ?? 0) < viewModel.originalHeight / 2 {
                closeView()
                return
            } else {
                superview?.layoutIfNeeded()
                if viewModel.state == .big(Float(viewModel.originalHeight)) {
                    if lastchangeArray.reduce(0, +) > 70 &&
                        (heightConst?.constant ?? 0) < (viewModel.originalHeight * 3) / 2 {
                        closeView()
                    } else {
                        animationToOriginalHeight()
                    }
                } else {
                    if lastchangeArray.reduce(0, +) < -60 {
                        viewModel.state = viewModel.bigState
                        animationToOriginalHeight()
                    } else {
                        animationToOriginalHeight()
                    }
                }
            }
        }
    }
    
    func closeView() {
        if viewModel.closeDisabled {
            if viewModel.state == .big(Float(viewModel.originalHeight)) {
                viewModel.state = viewModel.minimalState
                animationToOriginalHeight()
            } else {
                animationToOriginalHeight()
            }
            
            return
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.heightConst?.constant = 0
            self?.superview?.layoutIfNeeded()
            self?.grayView.removeFromSuperview()
            self?.grayViewSecondPart.removeFromSuperview()
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

}
