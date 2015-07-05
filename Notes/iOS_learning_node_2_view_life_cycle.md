# iOS 学习笔记2 —— 视图生命周期

视图生命周期间切换时调用的函数在视图对应的 controller 文件中。

## 视图控制器的主要方法：

```
func viewDidLoad() // Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.

func viewWillAppear(animated: Bool) // Called when the view is about to made visible. Default does nothing

func viewDidAppear(animated: Bool) // Called when the view has been fully transitioned onto the screen. Default does nothing

func viewWillDisappear(animated: Bool) // Called when the view is dismissed, covered or otherwise hidden. Default does nothing

func viewDidDisappear(animated: Bool) // Called after the view was dismissed, covered or otherwise hidden. Default does nothing

func didReceiveMemoryWarning() // Called when the parent application receives a memory warning. On iOS 6.0 it will no longer clear the view by default.	
```

## 视图控制器与应用声明周期之间的调用顺序（single view）

### 启动场景（点击应用图标）：

* Not running->Inactive->Active

```
2015-07-05 08:12:06.415 TabbedApplication[2571:298379] application:didFinishLaunchingWithOptions:
2015-07-05 08:12:53.840 TabbedApplication[2571:298379] viewDidLoad
2015-07-05 08:13:01.099 TabbedApplication[2571:298379] viewWillAppear:
2015-07-05 08:13:04.713 TabbedApplication[2571:298379] viewDidAppear
2015-07-05 08:13:11.366 TabbedApplication[2571:298379] applicationDidBecomeActive:
```

### 退出场景（点击 Home 键）

1. （若无特殊设定则为此情况）Supporting files->Info.plist 中有 Application does not run in background 为 NO

* Active->Inactive->Background->Suspended

```
2015-07-05 08:21:40.032 TabbedApplication[2714:352074] applicationWillResignActive
2015-07-05 08:21:41.682 TabbedApplication[2714:352074] applicationDidEnterBackground:
```

注意：此时没有调用 view controller 的任何方法，即此时 view 并没有被进行任何操作。换句话说，view controller 并不知道自己所在应用时处于前台还是后台。


2. Supporting files->Info.plist 中有 Application does not run in background 为 YES

* Active->Inactive->Background->Suspended->Not running

```
2015-07-05 08:19:54.356 TabbedApplication[2571:298379] applicationWillResignActive
2015-07-05 08:19:56.154 TabbedApplication[2571:298379] applicationDidEnterBackground:
2015-07-05 08:19:58.482 TabbedApplication[2571:298379] viewDidDisappear:
2015-07-05 08:19:59.308 TabbedApplication[2571:298379] viewDidDisappear
2015-07-05 08:20:00.608 TabbedApplication[2571:298379] applicationWillTerminate:
```

 **注意：** 当处于第一种情况时，长按 Home + 划走 app 的方法其实是清除应用内存。此时是通过发出 Signal 9 来杀掉应用进程的，应用不会调用前面介绍的任何状态迁移的方法，包括 view controller 内的方法。

### 挂起重新运行（长按 Home 选择应用）

Suspended->Background->Inactive->Active

```
2015-07-05 09:35:36.313 TabbedApplication[2948:458283] applicationWillEnterForeGround:
2015-07-05 09:35:36.824 TabbedApplication[2948:458283] applicationDidBecomeActive:
```

view controller 也不会有任何方法被调用

### 内存清除（系统自动清除或者用户长按 Home + 划走应用）

Background->Suspended->Not running

这期间应用不会调用任何方法，也不会发出任何通知。

## 总结

视图的生命周期相比应用的会简单不少，同时视图并不会知道应用处于何种状态（前台、后台、被关闭），只会知道自己合适被创建、变为可见、变为不可见、被回收。




