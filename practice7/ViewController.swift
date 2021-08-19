//
//  ViewController.swift
//  practice7
//
//  Created by Sakai Syunya on 2021/08/19.
//  Copyright © 2021 Sakai Syunya. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
        (0..<6).forEach { page in
            let imageView = generateImageView(at: page)
            scrollView.addSubview(imageView)
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = 6
        pageControl.currentPage = currentPage
        
        pageControl.addTarget(
            self,
            action: #selector(didValueChangePageControl),
            for: .valueChanged
        )
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 6
    }
    
    private func calculateScrollViewFrame(at page: Int) -> CGRect {
        var frame = scrollView.bounds
        frame.origin.x = calculateX(at: page)
        return frame
    }
    
    private func calculateX(at position: Int) -> CGFloat {
        return scrollView.bounds.width * CGFloat(position)
    }
    
    private func generateImageView(at page: Int) -> UIImageView {
        let frame = calculateScrollViewFrame(at: page)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"\(page)")
        
        return imageView
    }
    
    private func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        // コンテンツ幅 = ページ数 x ページ幅
        scrollView.contentSize = CGSize(width: scrollView.bounds.size.width * 6,height: scrollView.bounds.size.height)
    }
    
    @objc private func didValueChangePageControl() {
        currentPage = pageControl.currentPage
        let x = calculateX(at: currentPage)
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}

