# View controller init
1. init
2. init(nibName: _, bundle: _)

# View creation
1. isViewLoaded
2. loadView
3. viewDidLoad
4. initWithFrame
5. initWithCoder

# View changes
1. viewDidLoad
2. viewWillAppear
3. viewDidAppear
4. viewWillDisappear
5. viewDidDisappear

# Memory warning
1. didReceiveMemoryWarning

# Removing
1. deinit

```
class Controller: UIViewController {
    override func loadView() {
        super.loadView()
        * this method use when view Controller creates from code
        * loadView() is a method managed by the viewController
        * view Controller calls it when its current view is nil 
        * loadView() basically takes a view (that you create) and sets it to the viewController’s view (superview)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        * this method is loaded once in view controller life cycle
        * its called when all the view are loaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        * this method is called every time before the view is visible to and before any animation are configured
        * in this method view has bound but orientation not set yet
        * you can override this method to perform custom tasks associated with displaying the view such as to hide fields or disable actions before the view becomes visible
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        * when a view’s bounds change, the view adjusts the position of its subviews
        * view controller can override this method to make changes before the view lays out its subviews
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        * this method is called after the viewController has been adjust to its subview following a change on its bound
        * add code here if you want to make change to subviews after they have been set
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        * this method is called after the view present on the screen
        * usually save data to core data or start animation or start playing a video or a sound, or to start collecting data from the network this type of task good for this method
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        * this method called before the view are remove from the view hierarchy
        * the view is still on view hierarchy and not removed yet
        * add code here to handle timers, hide the keyboard, cancel network requests, revert any changes to the parent UI, save state
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        * this method is called after the controller's view has been removed from the view hierarchy
        * use this method to stop listening for notifications or device sensors
    }
    
    deinit {
        * Before a view controller is removed from memory, it gets deinitialized. 
        * You usually override deinit() to clean resources that the view controller has allocated that are not freed by ARC. 
        * Keep in mind that just because a VC is no longer visible, doesn’t mean that it has been deallocated, it can still be in memory, works normally and can receive notifications.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        * when memory starts to fill up, iOS does not automatically move data from memory to its limited hard disk space
        * it does, however, issue this warning and you are responsible for clearing some objects out of memory
        * be aware that if the memory of your app goes over a certain range, iOS will shutdown your app
        * unfortunately, this will look like a crash to the end user
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        * When the interface orientation changes, UIKit calls this method on the window’s root view controller before the size changes are about to be made.
        * The root view controller then notifies its child view controllers, propagating the message throughout the view controller hierarchy.  
        * The parameter to contains the new CGSize size of the container’s view and the parameter with contains a UIViewControllerTransitionCoordinator coordinator, an enum that describes the new orientation.
    }
}
```

# App life cycle

1. Сначала приложение не запущенно
2. Потом пользователь запускает приложение. Оно переходит в состояние Foreground
3. Сначала приложение становится Inactive —  на этом этапе выполняется код программы, но не обрабатываются события интерфейса пользователя (интерфейс не отображается, касания не обрабатываются и.т.п.)
4. Затем переходит в этап Active, в котором выполняется код и обрабатываются все события UI
5. Если пользователь запустит другое приложение, то текущее приложение перейдет в состояние Inactive и затем в состояние Background. В этом состоянии код выполняется ограниченное время, и не обрабатываются события UI. Приложение может получить из интернета самые свежие обновления, и дать их приложению, чтобы когда пользователь вернул приложение в Foreground он мог увидеть эту обновления
6. После весьма короткого состояния Background приложение переходит в состояние Suspended. В этом состоянии код не выполняется вовсе и система может убить приложение для освобождения памяти

<h2>Успешный запуск приложения</h2>

```
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    * This method is called after your application has been launched successfully. 
    * It is the first method from our app delegate , which will be called. You can execute your code if the launch was successful
    return true
}
```
<strong>Переключение на другое приложение или нажатие копки «Home».</strong>
```
func applicationWillResignActive(application: UIApplication) { }
```
<strong>Приложение перешло в состояние Active</strong>
* Если приложение пришло из состояния Background желательно обновить интерфейс
```
func applicationDidBecomeActive(application: UIApplication) { }
```
<strong>Переход в состояние Background</strong>
* Тут необходимо сохранять пользовательские данные, или сохранять состояние приложения, чтобы оно запустилось с места остановки
```
func applicationDidEnterBackground(application: UIApplication) { }
```
<strong>Переход из Background в состояние Foreground</strong>
```
func applicationWillEnterForeground(application: UIApplication) { }
```
<strong>Пользователь закрывает приложение</strong>
```
func applicationWillTerminate(application: UIApplication) { }
```
