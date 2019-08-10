# relative_layout

Flutter-RelativeLayout

Flutter上的相对布局RelativeLayout

## Usage

导入：
`import 'package:relative_layout/relative_layout.dart';`

然后就可以愉快的使用`RelativeLayout`了。具体可用属性见Example。

**要求：**
- children必须是`LayoutId`,并且`LayoutId`的`id`必须是`RelativeId`;
- `RelativeId`的`id`作为child寻找相对关系的身份标示，其值必须唯一
- **被依赖的child必须声明在依赖child之前。如一个child B要布局在child A的左侧，A要声明在B之前，然后B再使用` toLeftOf: 'A'`**

## Example

### 1、相对关系：`toLeftOf`,`toRightOf`,`above`,`below`

<img src="https://github.com/CCY0122/flutter_relative_layout/blob/master/pic/WechatIMG51.png" width=300/>

```dart
RelativeLayout(
                children: <LayoutId>[
                  LayoutId(
                    id: RelativeId('A'),
                    child: simpleContatiner(text: 'A', color: Colors.red),
                  ),
                  LayoutId(
                    id: RelativeId('B', toLeftOf: 'A'),
                    child: simpleContatiner(text: 'B', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('C', toRightOf: 'A'),
                    child: simpleContatiner(text: 'C', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('D', above: 'A'),
                    child: simpleContatiner(text: 'D', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('E', below: 'A'),
                    child: simpleContatiner(text: 'E', color: Colors.blue),
                  ),
                ],
              ),
```
组合使用:

<img src="https://github.com/CCY0122/flutter_relative_layout/blob/master/pic/WechatIMG52.png" width=300/>

```dart
 RelativeLayout(
                children: <LayoutId>[
                  LayoutId(
                    id: RelativeId('A'),
                    child: simpleContatiner(text: 'A', color: Colors.red),
                  ),
                  LayoutId(
                    id: RelativeId('B', toLeftOf: 'A',above: 'A'),
                    child: simpleContatiner(text: 'B', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('C', toLeftOf: 'B',below: 'A'),
                    child: simpleContatiner(text: 'C', color: Colors.blue),
                  ),
                  LayoutId(
                    //因为above已经指定了y轴上的位置，所以alignment只有x轴的位置会生效
                    id: RelativeId('D', above: 'A',alignment: Alignment.centerRight),
                    child: simpleContatiner(text: 'D', color: Colors.blue),
                  ),
                ],
              ),
```

### 2、轴对齐关系：`alignLeft`,`alignRight`,`alignTop`,`alignBottom`

<img src="https://github.com/CCY0122/flutter_relative_layout/blob/master/pic/WechatIMG53.png" width=300/>

```dart
 RelativeLayout(
                children: <LayoutId>[
                  LayoutId(
                    id: RelativeId('A'),
                    child: simpleContatiner(text: 'A', color: Colors.red,width: 180,height: 180),
                  ),
                  LayoutId(
                    id: RelativeId('B', alignTop: 'A'),
                    child: simpleContatiner(text: 'B', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('C', alignBottom: 'A'),
                    child: simpleContatiner(text: 'C', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('D', alignLeft: 'A'),
                    child: simpleContatiner(text: 'D', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('E', alignRight: 'A'),
                    child: simpleContatiner(text: 'E', color: Colors.blue),
                  ),
                ],
              ),
```

组合使用:

<img src="https://github.com/CCY0122/flutter_relative_layout/blob/master/pic/WechatIMG55.png" width=300/>

```dart
 RelativeLayout(
                children: <LayoutId>[
                  LayoutId(
                    id: RelativeId('A'),
                    child: simpleContatiner(text: 'A', color: Colors.red,width: 180,height: 180),
                  ),
                  LayoutId(
                    id: RelativeId('B', alignTop: 'A',toLeftOf: 'A'),
                    child: simpleContatiner(text: 'B', color: Colors.blue),
                  ),
                  LayoutId(
                    //因为alignBottom已经指定了y轴上的位置，所以alignment只有x轴会生效
                    id: RelativeId('C', alignBottom: 'A',alignment: Alignment.centerRight),
                    child: simpleContatiner(text: 'C', color: Colors.blue),
                  ),
                  LayoutId(
                    id: RelativeId('D', alignLeft: 'A',alignTop: 'C',),
                    child: simpleContatiner(text: 'D', color: Colors.blue,height: 100,width: 100),
                  ),
                ],
              ),
```
### 3、溢出模式

<img src="https://github.com/CCY0122/flutter_relative_layout/blob/master/pic/WechatIMG54.png" width=300/>

```dart
 RelativeLayout(
                children: <LayoutId>[
                  LayoutId(
                    id: RelativeId('A'),
                    child: simpleContatiner(text: 'A', color: Colors.red,width: 180,height: 180),
                  ),
                  LayoutId(
                  //可以溢出父布局
                    id: RelativeId('B', above: 'A',alignment: Alignment(-0.5,0),overFlow: RelativeOverFlow.overflow),
                    child: simpleContatiner(text: 'B', color: Colors.blue,height: 200),
                  ),
                  LayoutId(
                  //不可以溢出父布局
                    id: RelativeId('C', above: 'A',alignment: Alignment(0.5,0),overFlow: RelativeOverFlow.inside),
                    child: simpleContatiner(text: 'C', color: Colors.blue,height: 200),
                  ),
                ],
              ),
```
(没有支持`clip`溢出模式（即溢出父布局的部分被裁剪）,可以通过给布局嵌套一层`ClipRect`实现。）

`simpleContatiner`:
```dart
  Widget simpleContatiner({
    Color color = Colors.red,
    double width = 50,
    double height = 50,
    String text = 'A',
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
```
