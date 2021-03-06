//
//  ViewController.swift
//  PageApp
//
//  Created by JHJG on 2016. 7. 13..
//  Copyright © 2016년 KangJungu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    //UIPageViewController의 DataSource는 애플리케이션의 viewController의 클래스가 된다.
    var pageController:UIPageViewController?
    
    //조금씩 다른 html로 구성된 여러 개의 문자열 객체를 수용하는 배열 객체
    var pageContent = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 모델 구성
        createContentPages()
        
        //페이지가 접히는 것을 설정하고 이동방햐을 수평으로 설정한 UIPageViewController 클래스의 인스턴스를 생성
        pageController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
        //현재 클래스는 페이지 컨트롤러를 위한 데이터 소스이자 델리게이트로 동작할것이므로 이렇게 설정해준다.
        pageController?.delegate = self
        pageController?.dataSource = self
        
        //첫번 째 페이지를 표시하기위해 뷰컨트롤러 생성하고
        let startingViewController: ContentViewController = viewControllerAtIndex(0)!
        //위에서 생성한 뷰컨트롤러를 배열객체에 할당한다.
        let viewControllers: NSArray = [startingViewController]
        //콘텐트 뷰 컨트롤러를 저장하고 있는 배열이 완성되면 이 배열을 뷰 컨트롤러에 할당해야함. 내비게이션 방향은 앞쪽으로 설정
        pageController?.setViewControllers(viewControllers as?[UIViewController],
                                           direction: .Forward,
                                           animated: false,
                                           completion: nil)
        
        //페이지 뷰 컨트롤러를 현재의 뷰애 추가한다.
        self.addChildViewController(pageController!)
        self.view.addSubview(self.pageController!.view)
        
        //페이지가 전체화면을 가득 채우도록하는 코드를 추가한다.
        let pageViewRect = self.view.bounds
        pageController!.view.frame = pageViewRect
        pageController!.didMoveToParentViewController(self)
    }
    
    //html 문자열로 배열을 구성하는 메서드
    func createContentPages(){
        var pageStrings = [String]()
        
        for i in 1...11{
            let contentString = "<html><head></head><body><br><h1>Chapter\(i)</h1><p>This is the Page \(i) of content displayed using UIPageViewController in iOS9.</p></body></html>"
            pageStrings.append(contentString)
        }
        
        pageContent = pageStrings
    }
    
    
    func viewControllerAtIndex(index: Int) -> ContentViewController? {
        
        //인덱스가 0이면 첫페이지 전으로 이동할수 없음 
        //또는 pagecontent 배열의 항목 개수보다 큰 숫자인지 체크
        if(pageContent.count == 0) || (index >= pageContent.count){
            return nil
        }
        
        //index 값이 유효하면 ContentViewController 클래스의 인스턴스가 새로 만들어지며, dataObject 속성은 해당되는 pageContent 배열의 항목(HTML 문자열)으로 설정된다.
        //이 뷰 컨트롤러는 스토리보드 파일에 저장되어 있으므로 다음 코드는 스토리 보드에 대한 참조체를 얻어서 새로운 ContentViewController 인스턴스 생성하는 데 사용된다.
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let dataViewController = storyBoard.instantiateViewControllerWithIdentifier("contentView") as! ContentViewController
        dataViewController.dataObject = pageContent[index]
        
        return dataViewController
    }
    
    //view controller 객체를 전달받고 컨트롤러의 인덱스 값을 반환한다. 또한, 뷰 컨트롤러의 dataObject 속성을 찾아내고 pageContent 배열에서 일치하는 요소의 인덱스를 찾는다.
    func indexOfViewController(viewController: ContentViewController) -> Int {
        
        if let dataObject: AnyObject = viewController.dataObject {
            return pageContent.indexOfObject(dataObject)
        }else{
            return NSNotFound
        }
    }
    
    //현재 뷰 컨트롤러의 앞쪽 뷰 컨트롤러를 반환하는 메서드
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! ContentViewController)
        
        //index가 0이면 앞쪽이 없음 또는 NSNotFound 이면 nil 리턴
        if (index == 0) || (index == NSNotFound){
            return nil
        }
        
        index -= 1
        //이전페이지 리턴
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! ContentViewController)
        
        //NSNotFound 이면 nil
        if index == NSNotFound{
            return nil
        }
        
        index += 1
        // +1해서 count와 같으면 nil 리턴(count는 1부터 시작하므로 이미 마지막 쪽이라는것)
        if(index == pageContent.count){
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
}

