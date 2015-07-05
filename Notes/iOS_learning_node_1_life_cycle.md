# iOS 学习笔记1 —— 生命周期

生命周期间切换时调用的函数在 AppDelegate 文件中。

## 应用的五种状态间切换：

### 启动场景（点击应用图标）：

* Not running->Inactive->Active

Not running->Inactive 期间调用 `application:didFinishLaunchingWithOptions:`，发出 `UIApplicationDidFinishLaunchingNotification` 通知。

Inactive：界面上停留在 LaunchScreen

Inactive->Active 期间调用 `applicationDidBecomeActive:` 方法，发出 `UIApplicationDidBecomeActiveNotification` 通知。

Active：界面上关闭 LaunchScreen，进入应用主界面

### 退出场景（点击 Home 键）

两种情况：


1. （若无特殊设定则为此情况）Supporting files->Info.plist 中有 Application does not run in background 为 NO
2. Supporting files->Info.plist 中有 Application does not run in background 为 YES

第一种情况：

Active->Inactive->Background->Suspended

Active->Inactive 期间调用 `applicationWillResignActive`，发出 `UIApplicationWillResignActiveNotification`

Inactive->Background 期间不涉及 Delegate 中的方法

Background->Suspended 期间调用 `applicationDidEnterBackground:`，发出 `UIApplicationDidEnterBackgroundNotification`

第二种情况：

Active->Inactive->Background->Suspended->Not running

Active-Inactive 期间调用 `applicationWillResignActive`，发出 `UIApplicationWillResignActiveNotification`

Inactive->Background 期间不涉及 Delegate 中的方法

Background->Suspended 期间调用 `applicationDidEnterBackground:`，发出 `UIApplicationDidEnterBackgroundNotification`

Suspended->Not running 期间调用 `applicationWillTerminate:`，发出 `UIApplicationWillTerminateNotification`

 **注意：** 当处于第一种情况时，长按 Home + 划走 app 的方法其实是清除应用内存。此时是通过发出 Signal 9 来杀掉应用进程的，应用不会调用前面介绍的任何状态迁移的方法。

### 挂起重新运行（长按 Home 选择应用）

Suspended->Background->Inactive->Active

Suspended->Background 期间不涉及 Delegate 中的方法

Background->Inactive 期间调用 `applicationWillEnterForeground:`，发出 `UIApplicationWillEnterForegroundNotification`

Inactive->Active 期间调用 `applicationDidBecomeActive:`，发出 `applicationDidBecomeActiveNofification`

存在问题：如果应用处于前面提到的第二种情况，即不允许在后台运行，那么它的挂起重新运行是否一样流程？目测来看不一样，因为直接在任务管理器选择应用时不会再出现 LaunchScreen ，但如果是点击应用图标启动应用则会有 LaunchScreen。

### 内存清除（系统自动清除或者用户长按 Home + 划走应用）

Background->Suspended->Not running

这期间应用不会调用任何方法，也不会发出任何通知。

## 总结

应用生命周期和 Android 的类似，不同之处在于有一个可以设置是否可以后台运行的参数，以及不是所有状态切换都会有指定方法被调用。

存疑：如果应用处于前面提到的第二种情况，即不允许在后台运行，那么它的挂起重新运行是否一样流程？目测来看不一样，因为直接在任务管理器选择应用时不会再出现 LaunchScreen ，但如果是点击应用图标启动应用则会有 LaunchScreen。需要通过查看系统 log 确定。

答案：通过 `idevicesyslog | grep myappname` 命令查看设备实时 Log 发现不允许后台运行的挂起重新运行走的是应用启动流程（带有 `application:didFinishLaunchingWithOptions:`）。
在任务管理器选择时不会出现 LaunchScreen 只是假象，系统会把任务选择器里面的截图作为 LaunchScreen 来用（验证方法：在 `application:didFinishLaunchingWithOptions:` 中加入 sleep ，然后使用任务管理器选择应用，会发现应用刚恢复时界面怎么点击都不会有反应，即此时处于 LaunchScreen 状态），因此实际上还是有调用 `application:didFinishLaunchingWithOptions:` 的。


