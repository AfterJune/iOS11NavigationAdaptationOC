# iOS11NavigationAdaptationOC
Adaptation for iOS11 NavagitonBar with Objective-C

## There are two ways to use this Adaptor:
### 1.Add the files below to your project
```
NSObject+Tracker.h
NSObject+Tracker.m
UINavigationItem+Tracker.h
UINavigationItem+Tracker.m
```
You need to change revise two parameters in `UINavigationItem+Tracker.m`:
```
static CGFloat margin = 5.0;
static CGFloat space = 1.0;
```
`margin`: The distance of the `_UIButtonBarStackView` to the leading or trailing of NavigationBar;
`space`:The distance of the BarButtonItems in `_UIButtonBarStackView`;
### 2.Add the files below to your project
```
NSObject+Tracker.h
NSObject+Tracker.m
UIView+Tracker.h
UIView+Tracker.m
```
You need to change revise two parameters in `UINavigationItem+Tracker.m`:
```
static CGFloat margin = 5.0;
static CGFloat space = 1.0;
```
`margin`: The distance of the `_UIButtonBarStackView` to the leading or trailing of NavigationBar;
`space`:The distance of the BarButtonItems in `_UIButtonBarStackView`;
