//
//  ViewController.swift
//  pagerView_tutorial
//
//  Created by SeungMin on 2021/04/14.
//

import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {

    fileprivate let imageNames = ["1.jpeg", "2.jpeg", "3.jpg", "4.jpg"]
    
    
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBOutlet weak var rightBtn: UIButton!
    
    
    
    
    @IBOutlet weak var myPagerView: FSPagerView! {
        // PagerView의 설정 값을 미리 설정 하기
        didSet {
            // 페이지뷰에 셀을 등록한다.
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            // 아이템 크기 설정
            self.myPagerView.itemSize = FSPagerViewAutomaticSize
            // 무한 스크롤 설정
            self.myPagerView.isInfinite = true
            // 자동 스크롤 설정
            self.myPagerView.automaticSlidingInterval = 4.0
        }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl! {
        // PagerView의 설정 값을 미리 설정 하기
        didSet {
            self.myPageControl.numberOfPages = self.imageNames.count
            self.myPageControl.contentHorizontalAlignment = . center
            self.myPageControl.itemSpacing = 15
//            self.myPageControl.interitemSpacing = 16
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // selfsms UIViewController가 아닌 FSPagerViewDataSource, FSPagerViewDelegate
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height / 2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height / 2
    }
    
    // MARK: - IBActions
    @IBAction func onLeftBtnClicked(_ sender: UIButton) {
        print("ViewController - onLeftBtnClicked() called")
        self.myPageControl.currentPage = (myPageControl.currentPage - 1) % self.imageNames.count
        self.myPagerView.scrollToItem(at: myPageControl.currentPage, animated: true)
    }
    
    @IBAction func onRightBtnClicked(_ sender: UIButton) {
        print("ViewController - onRightBtnClicked() called")
        self.myPageControl.currentPage = (myPageControl.currentPage + 1) % self.imageNames.count
        self.myPagerView.scrollToItem(at: myPageControl.currentPage, animated: true)
    }
    
    // MARK: - FSPagerView DataSource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
//        cell.textLabel?.text = ...
        return cell
    }

    // MARK: FSPagerView Delegate
    // 드래그로 페이지를 넘길 때, pageControl도 동시에 넘기기
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    
    // 자동 스크롤로 페이지가 넘어갈 때, pageControl도 동시에 넘기기
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

