// MARK: - Mocks generated from file: Trav-Book/Dashboard/DashboardViewModel.swift at 2020-09-24 11:58:37 +0000

//
//  DashboardViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Cuckoo
@testable import Trav_Book

import Combine
import Firebase
import Foundation


 class MockDashboardViewModel: DashboardViewModel, Cuckoo.ClassMock {
    
     typealias MocksType = DashboardViewModel
    
     typealias Stubbing = __StubbingProxy_DashboardViewModel
     typealias Verification = __VerificationProxy_DashboardViewModel

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: DashboardViewModel?

     func enableDefaultImplementation(_ stub: DashboardViewModel) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var ref: DatabaseReference {
        get {
            return cuckoo_manager.getter("ref",
                superclassCall:
                    
                    super.ref
                    ,
                defaultCall: __defaultImplStub!.ref)
        }
        
        set {
            cuckoo_manager.setter("ref",
                value: newValue,
                superclassCall:
                    
                    super.ref = newValue
                    ,
                defaultCall: __defaultImplStub!.ref = newValue)
        }
        
    }
    
    
    
     override var postsModelUpdatedRealTime: PostsModel? {
        get {
            return cuckoo_manager.getter("postsModelUpdatedRealTime",
                superclassCall:
                    
                    super.postsModelUpdatedRealTime
                    ,
                defaultCall: __defaultImplStub!.postsModelUpdatedRealTime)
        }
        
        set {
            cuckoo_manager.setter("postsModelUpdatedRealTime",
                value: newValue,
                superclassCall:
                    
                    super.postsModelUpdatedRealTime = newValue
                    ,
                defaultCall: __defaultImplStub!.postsModelUpdatedRealTime = newValue)
        }
        
    }
    
    
    
     override var switchSubscriber: Set<AnyCancellable> {
        get {
            return cuckoo_manager.getter("switchSubscriber",
                superclassCall:
                    
                    super.switchSubscriber
                    ,
                defaultCall: __defaultImplStub!.switchSubscriber)
        }
        
        set {
            cuckoo_manager.setter("switchSubscriber",
                value: newValue,
                superclassCall:
                    
                    super.switchSubscriber = newValue
                    ,
                defaultCall: __defaultImplStub!.switchSubscriber = newValue)
        }
        
    }
    
    
    
     override var postsModel: PostsModel? {
        get {
            return cuckoo_manager.getter("postsModel",
                superclassCall:
                    
                    super.postsModel
                    ,
                defaultCall: __defaultImplStub!.postsModel)
        }
        
        set {
            cuckoo_manager.setter("postsModel",
                value: newValue,
                superclassCall:
                    
                    super.postsModel = newValue
                    ,
                defaultCall: __defaultImplStub!.postsModel = newValue)
        }
        
    }
    
    
    
     override var isLoading: Bool {
        get {
            return cuckoo_manager.getter("isLoading",
                superclassCall:
                    
                    super.isLoading
                    ,
                defaultCall: __defaultImplStub!.isLoading)
        }
        
        set {
            cuckoo_manager.setter("isLoading",
                value: newValue,
                superclassCall:
                    
                    super.isLoading = newValue
                    ,
                defaultCall: __defaultImplStub!.isLoading = newValue)
        }
        
    }
    
    
    
     override var isRefresh: Bool {
        get {
            return cuckoo_manager.getter("isRefresh",
                superclassCall:
                    
                    super.isRefresh
                    ,
                defaultCall: __defaultImplStub!.isRefresh)
        }
        
        set {
            cuckoo_manager.setter("isRefresh",
                value: newValue,
                superclassCall:
                    
                    super.isRefresh = newValue
                    ,
                defaultCall: __defaultImplStub!.isRefresh = newValue)
        }
        
    }
    
    
    
     override var posts: [PostModel] {
        get {
            return cuckoo_manager.getter("posts",
                superclassCall:
                    
                    super.posts
                    ,
                defaultCall: __defaultImplStub!.posts)
        }
        
        set {
            cuckoo_manager.setter("posts",
                value: newValue,
                superclassCall:
                    
                    super.posts = newValue
                    ,
                defaultCall: __defaultImplStub!.posts = newValue)
        }
        
    }
    

    

    
    
    
     override func add(x: Int, y: Int) -> Int {
        
    return cuckoo_manager.call("add(x: Int, y: Int) -> Int",
            parameters: (x, y),
            escapingParameters: (x, y),
            superclassCall:
                
                super.add(x: x, y: y)
                ,
            defaultCall: __defaultImplStub!.add(x: x, y: y))
        
    }
    
    
    
     override func refresh()  {
        
    return cuckoo_manager.call("refresh()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.refresh()
                ,
            defaultCall: __defaultImplStub!.refresh())
        
    }
    
    
    
     override func getData()  {
        
    return cuckoo_manager.call("getData()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getData()
                ,
            defaultCall: __defaultImplStub!.getData())
        
    }
    
    
    
     override func update(numberOfLikes: PostModel)  {
        
    return cuckoo_manager.call("update(numberOfLikes: PostModel)",
            parameters: (numberOfLikes),
            escapingParameters: (numberOfLikes),
            superclassCall:
                
                super.update(numberOfLikes: numberOfLikes)
                ,
            defaultCall: __defaultImplStub!.update(numberOfLikes: numberOfLikes))
        
    }
    
    
    
     override func request(completion: ((Welcome?, Error?) -> Void)?)  {
        
    return cuckoo_manager.call("request(completion: ((Welcome?, Error?) -> Void)?)",
            parameters: (completion),
            escapingParameters: (completion),
            superclassCall:
                
                super.request(completion: completion)
                ,
            defaultCall: __defaultImplStub!.request(completion: completion))
        
    }
    

	 struct __StubbingProxy_DashboardViewModel: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var ref: Cuckoo.ClassToBeStubbedProperty<MockDashboardViewModel, DatabaseReference> {
	        return .init(manager: cuckoo_manager, name: "ref")
	    }
	    
	    
	    var postsModelUpdatedRealTime: Cuckoo.ClassToBeStubbedOptionalProperty<MockDashboardViewModel, PostsModel> {
	        return .init(manager: cuckoo_manager, name: "postsModelUpdatedRealTime")
	    }
	    
	    
	    var switchSubscriber: Cuckoo.ClassToBeStubbedProperty<MockDashboardViewModel, Set<AnyCancellable>> {
	        return .init(manager: cuckoo_manager, name: "switchSubscriber")
	    }
	    
	    
	    var postsModel: Cuckoo.ClassToBeStubbedOptionalProperty<MockDashboardViewModel, PostsModel> {
	        return .init(manager: cuckoo_manager, name: "postsModel")
	    }
	    
	    
	    var isLoading: Cuckoo.ClassToBeStubbedProperty<MockDashboardViewModel, Bool> {
	        return .init(manager: cuckoo_manager, name: "isLoading")
	    }
	    
	    
	    var isRefresh: Cuckoo.ClassToBeStubbedProperty<MockDashboardViewModel, Bool> {
	        return .init(manager: cuckoo_manager, name: "isRefresh")
	    }
	    
	    
	    var posts: Cuckoo.ClassToBeStubbedProperty<MockDashboardViewModel, [PostModel]> {
	        return .init(manager: cuckoo_manager, name: "posts")
	    }
	    
	    
	    func add<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(x: M1, y: M2) -> Cuckoo.ClassStubFunction<(Int, Int), Int> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: x) { $0.0 }, wrap(matchable: y) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDashboardViewModel.self, method: "add(x: Int, y: Int) -> Int", parameterMatchers: matchers))
	    }
	    
	    func refresh() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDashboardViewModel.self, method: "refresh()", parameterMatchers: matchers))
	    }
	    
	    func getData() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDashboardViewModel.self, method: "getData()", parameterMatchers: matchers))
	    }
	    
	    func update<M1: Cuckoo.Matchable>(numberOfLikes: M1) -> Cuckoo.ClassStubNoReturnFunction<(PostModel)> where M1.MatchedType == PostModel {
	        let matchers: [Cuckoo.ParameterMatcher<(PostModel)>] = [wrap(matchable: numberOfLikes) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDashboardViewModel.self, method: "update(numberOfLikes: PostModel)", parameterMatchers: matchers))
	    }
	    
	    func request<M1: Cuckoo.OptionalMatchable>(completion: M1) -> Cuckoo.ClassStubNoReturnFunction<(((Welcome?, Error?) -> Void)?)> where M1.OptionalMatchedType == ((Welcome?, Error?) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(((Welcome?, Error?) -> Void)?)>] = [wrap(matchable: completion) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDashboardViewModel.self, method: "request(completion: ((Welcome?, Error?) -> Void)?)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DashboardViewModel: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var ref: Cuckoo.VerifyProperty<DatabaseReference> {
	        return .init(manager: cuckoo_manager, name: "ref", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var postsModelUpdatedRealTime: Cuckoo.VerifyOptionalProperty<PostsModel> {
	        return .init(manager: cuckoo_manager, name: "postsModelUpdatedRealTime", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var switchSubscriber: Cuckoo.VerifyProperty<Set<AnyCancellable>> {
	        return .init(manager: cuckoo_manager, name: "switchSubscriber", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var postsModel: Cuckoo.VerifyOptionalProperty<PostsModel> {
	        return .init(manager: cuckoo_manager, name: "postsModel", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var isLoading: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isLoading", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var isRefresh: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isRefresh", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var posts: Cuckoo.VerifyProperty<[PostModel]> {
	        return .init(manager: cuckoo_manager, name: "posts", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func add<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(x: M1, y: M2) -> Cuckoo.__DoNotUse<(Int, Int), Int> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: x) { $0.0 }, wrap(matchable: y) { $0.1 }]
	        return cuckoo_manager.verify("add(x: Int, y: Int) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func refresh() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("refresh()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getData() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getData()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func update<M1: Cuckoo.Matchable>(numberOfLikes: M1) -> Cuckoo.__DoNotUse<(PostModel), Void> where M1.MatchedType == PostModel {
	        let matchers: [Cuckoo.ParameterMatcher<(PostModel)>] = [wrap(matchable: numberOfLikes) { $0 }]
	        return cuckoo_manager.verify("update(numberOfLikes: PostModel)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func request<M1: Cuckoo.OptionalMatchable>(completion: M1) -> Cuckoo.__DoNotUse<(((Welcome?, Error?) -> Void)?), Void> where M1.OptionalMatchedType == ((Welcome?, Error?) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(((Welcome?, Error?) -> Void)?)>] = [wrap(matchable: completion) { $0 }]
	        return cuckoo_manager.verify("request(completion: ((Welcome?, Error?) -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DashboardViewModelStub: DashboardViewModel {
    
    
     override var ref: DatabaseReference {
        get {
            return DefaultValueRegistry.defaultValue(for: (DatabaseReference).self)
        }
        
        set { }
        
    }
    
    
     override var postsModelUpdatedRealTime: PostsModel? {
        get {
            return DefaultValueRegistry.defaultValue(for: (PostsModel?).self)
        }
        
        set { }
        
    }
    
    
     override var switchSubscriber: Set<AnyCancellable> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Set<AnyCancellable>).self)
        }
        
        set { }
        
    }
    
    
     override var postsModel: PostsModel? {
        get {
            return DefaultValueRegistry.defaultValue(for: (PostsModel?).self)
        }
        
        set { }
        
    }
    
    
     override var isLoading: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
    
     override var isRefresh: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
    
     override var posts: [PostModel] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([PostModel]).self)
        }
        
        set { }
        
    }
    

    

    
     override func add(x: Int, y: Int) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
     override func refresh()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getData()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func update(numberOfLikes: PostModel)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func request(completion: ((Welcome?, Error?) -> Void)?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockPostModel: PostModel, Cuckoo.ClassMock {
    
     typealias MocksType = PostModel
    
     typealias Stubbing = __StubbingProxy_PostModel
     typealias Verification = __VerificationProxy_PostModel

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: PostModel?

     func enableDefaultImplementation(_ stub: PostModel) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var id: UUID {
        get {
            return cuckoo_manager.getter("id",
                superclassCall:
                    
                    super.id
                    ,
                defaultCall: __defaultImplStub!.id)
        }
        
        set {
            cuckoo_manager.setter("id",
                value: newValue,
                superclassCall:
                    
                    super.id = newValue
                    ,
                defaultCall: __defaultImplStub!.id = newValue)
        }
        
    }
    
    
    
     override var name: String? {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    super.name
                    ,
                defaultCall: __defaultImplStub!.name)
        }
        
        set {
            cuckoo_manager.setter("name",
                value: newValue,
                superclassCall:
                    
                    super.name = newValue
                    ,
                defaultCall: __defaultImplStub!.name = newValue)
        }
        
    }
    
    
    
     override var imageName: String? {
        get {
            return cuckoo_manager.getter("imageName",
                superclassCall:
                    
                    super.imageName
                    ,
                defaultCall: __defaultImplStub!.imageName)
        }
        
        set {
            cuckoo_manager.setter("imageName",
                value: newValue,
                superclassCall:
                    
                    super.imageName = newValue
                    ,
                defaultCall: __defaultImplStub!.imageName = newValue)
        }
        
    }
    
    
    
     override var postText: String? {
        get {
            return cuckoo_manager.getter("postText",
                superclassCall:
                    
                    super.postText
                    ,
                defaultCall: __defaultImplStub!.postText)
        }
        
        set {
            cuckoo_manager.setter("postText",
                value: newValue,
                superclassCall:
                    
                    super.postText = newValue
                    ,
                defaultCall: __defaultImplStub!.postText = newValue)
        }
        
    }
    
    
    
     override var numberOfLike: Int? {
        get {
            return cuckoo_manager.getter("numberOfLike",
                superclassCall:
                    
                    super.numberOfLike
                    ,
                defaultCall: __defaultImplStub!.numberOfLike)
        }
        
        set {
            cuckoo_manager.setter("numberOfLike",
                value: newValue,
                superclassCall:
                    
                    super.numberOfLike = newValue
                    ,
                defaultCall: __defaultImplStub!.numberOfLike = newValue)
        }
        
    }
    

    

    

	 struct __StubbingProxy_PostModel: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var id: Cuckoo.ClassToBeStubbedProperty<MockPostModel, UUID> {
	        return .init(manager: cuckoo_manager, name: "id")
	    }
	    
	    
	    var name: Cuckoo.ClassToBeStubbedOptionalProperty<MockPostModel, String> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var imageName: Cuckoo.ClassToBeStubbedOptionalProperty<MockPostModel, String> {
	        return .init(manager: cuckoo_manager, name: "imageName")
	    }
	    
	    
	    var postText: Cuckoo.ClassToBeStubbedOptionalProperty<MockPostModel, String> {
	        return .init(manager: cuckoo_manager, name: "postText")
	    }
	    
	    
	    var numberOfLike: Cuckoo.ClassToBeStubbedOptionalProperty<MockPostModel, Int> {
	        return .init(manager: cuckoo_manager, name: "numberOfLike")
	    }
	    
	    
	}

	 struct __VerificationProxy_PostModel: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var id: Cuckoo.VerifyProperty<UUID> {
	        return .init(manager: cuckoo_manager, name: "id", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var name: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var imageName: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "imageName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var postText: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "postText", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var numberOfLike: Cuckoo.VerifyOptionalProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "numberOfLike", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class PostModelStub: PostModel {
    
    
     override var id: UUID {
        get {
            return DefaultValueRegistry.defaultValue(for: (UUID).self)
        }
        
        set { }
        
    }
    
    
     override var name: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
     override var imageName: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
     override var postText: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
     override var numberOfLike: Int? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int?).self)
        }
        
        set { }
        
    }
    

    

    
}

