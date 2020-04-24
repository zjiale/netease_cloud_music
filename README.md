> ## **网易云音乐练手项目**

第一次写比较复杂的flutter项目，就在这里记录下。

### 项目目录
![image](https://github.com/zjiale/netease_cloud_music/blob/master/%E9%A1%B9%E7%9B%AE%E7%9B%AE%E5%BD%95.png)

api------>接口相关文件
model------>实体类文件
screens------>软件页面
store------>状态管理
utils------>配置文件
widgets------>公共widget

### 部分截图
![](https://media.giphy.com/media/Md4QEVfIpdNhHhkKBA/giphy.gif)
![](https://media.giphy.com/media/ZeFieOldqOLNUZXe9N/giphy.gif)
![](https://media.giphy.com/media/ejE7fdSVDQHvZWwsz7/giphy.gif)
![](https://media.giphy.com/media/WPohEW7C1a84wnDUgO/giphy.gif)
![](https://media.giphy.com/media/UsGr5BnbsxLxnIPl4B/giphy.gif)
![](https://media.giphy.com/media/Ph6BKCW0qMYuIm3hec/giphy.gif)

### TO DO LIST
- [ ] 评论功能
- [ ] 视频功能(fijkplayer可能需要更换)
- [ ] 动态歌词
- [ ] 播放列表
- [ ] 新建歌单
- [ ] 云村动态图片点击事件 
- [ ] 播放是缓存条显示 

- 还有以上功能需要增加，不过也只是目前想要增加的，项目目前需要暂停了，所以只做记录，可能以后回来继续更新。
- 目前动态歌词可以参考以上文章的链接，评论功能使用extended_textfield来进行文本输入以及表情插入，播放列表根据网易云app显示是使用swiper来进行数据的显示，缓存条在做云村动态的时候看到有缓存slider控件可以使用那个来进行缓存条的显示。

### 目前存在问题
1. 首页同时加载5个排行榜信息量过大会导致ui阻塞，加载的时候会产生卡顿，尝试过使用isolate来进行json解析，卡顿解决了，但是首页加载时间变长了体验很不好。
2.  歌单广场tabbar和swiper产生滑动冲突，如果禁止tabbar滑动，swiper那里就能够进行滑动，目前有解决办法还没有实现，详情点击[这里](https://juejin.im/post/5bea90c6e51d450319791b2e)。
3. 在搜索输入框比如输入文字之后想要点击右侧的清除按钮，点击一次是清除了，但是按钮还是显示着需要再次点击才会消失。
4. 适配问题还没有做，如果在其他手机上显示可能会出现超出区域限制提示。


### 参考链接
[网易云接口](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=neteasecloudmusicapi)

[项目开始参考文章](https://juejin.im/post/5d9de9a2e51d4578282ce25a)

[云村动态位置信息](https://juejin.im/post/5b6375f8e51d45190f4af4c2#heading-7)
