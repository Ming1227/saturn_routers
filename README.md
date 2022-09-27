# saturn_routers

一个路由选择的 module

## 使用方法

在依赖库中添加：

```
dependencies:
  saturn_routers:
    git:
      url: https://github.com/Ming1227/saturn_routers.git
      // 指定分支
      ref: master
```

枚举：SCRoutersDirection

```
enum SCRoutersDirection {
  rightToLeft, // 从右往左推出界面
  bottomToTop, // 从下往上推出界面
  material, // 根据系统自行选择
}
```

主要方法：

```
/*
  推出新的界面
  context 上下文
  widget 新界面
  routeName route标识
  direction 方向
*/
Future push(
  BuildContext context,
  Widget widget, {
  String? routeName,
  SCRoutersDirection direction = SCRoutersDirection.material,
})

// 返回上一个界面
Future pop(BuildContext context)

// 返回指定的界面
Future popUtil(BuildContext context, String routeName)

// 推出已注册过的界面替换当前的界面
Future pushReplace(BuildContext context, String routeName)

```
