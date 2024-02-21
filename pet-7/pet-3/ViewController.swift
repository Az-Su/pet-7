//
//  ViewController.swift
//  pet-3
//
//  Created by Sailau Almaz Maratuly on 08.02.2024.
//


import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    let parentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image")
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var contentViewTopAnchor: NSLayoutConstraint!
    var headerViewHeightAnchor: NSLayoutConstraint!
    var safeAreaHeight: CGFloat = 0
    let DeviceSize = UIScreen.main.bounds.size

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.hidesBarsOnSwipe = true
        parentScrollView.delegate = self
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        safeAreaHeight = self.view.safeAreaInsets.top
        parentScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 270-safeAreaHeight, left: 0, bottom: 0, right: 0)
    }
}

extension ViewController {
    func setupView(){
        view.backgroundColor = .white
        
        // ParentScrollView
        view.addSubview(parentScrollView)
        NSLayoutConstraint.activate([
            parentScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            parentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            parentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            parentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        parentScrollView.contentSize = CGSize(width: DeviceSize.width,
                                              height: DeviceSize.height*2)
        
        // ContentView
        parentScrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: parentScrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalToConstant: parentScrollView.contentSize.width),
            contentView.heightAnchor.constraint(equalToConstant: parentScrollView.contentSize.height),
        ])
        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: parentScrollView.contentLayoutGuide.topAnchor, constant: 0)
        contentViewTopAnchor.isActive = true
        
        
        // HeaderView
        contentView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])
        headerViewHeightAnchor = headerView.heightAnchor.constraint(equalToConstant: 270)
        headerViewHeightAnchor.isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetheight = scrollView.contentOffset.y
        
        if contentOffsetheight < 0 {
            contentViewTopAnchor.constant   = contentOffsetheight
            headerViewHeightAnchor.constant = 270 + (-contentOffsetheight)
            parentScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 270-safeAreaHeight-contentOffsetheight, left: 0, bottom: 0, right: 0)
        }
    }
}
