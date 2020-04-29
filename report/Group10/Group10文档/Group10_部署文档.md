**开发环境**

- macOS 10.14.6
- Xcode 10.1
- 模拟器 iPhone5S
- 真机调试 iPhone5C

**环境依赖**

- nodejs
- 需要libstdc++库的支持，安装请参见https://github.com/devdawei/libstdc-

**部署运行**

- 先完成前面环境依赖的配置
- 进入server文件夹，在RunCoin文件夹下，先执行npm install,然后`node ./bin/www` 
- 进入client文件夹下，打开`MyProject.xcworkspace` ，选择对应模拟器/真机运行，如果报错，请先`pod install` 