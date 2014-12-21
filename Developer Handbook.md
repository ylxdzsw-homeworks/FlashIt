Developer Handbook
==================
##风格
###类型系统
本项目不使用prototype和其它强制性的类继承和类型判断，全部采用鸭子类型。
“类”在本项目中表现为一个闭包，类的构造函数等价于类本身

##模块
### Parser
包含此文件后，将在全局环境中产生一个Parser函数，该函数无需参数，返回一个parse函数
parse函数描述如下：
* 接受一个codeElement作为参数
* 若codeElement不为表达式将throw Error
* 返回一个数组，数组元素为一次解析后的codeElement

### Translator
包含此文件后，将在全局环境中产生一个Translator函数，该函数接受一个zone作为参数，返回一个translate函数
translate函数描述如下：
* 接受一个codeElement作为参数
* 若codeElement不为单词则throw Error
* 返回一个objElement

### Evaler
包含此文件后，将在全局环境中产生一个Evaler函数，该函数无需参数，返回一个eval函数
eval函数描述如下：
* 接受一个由至少一个objElement组成的数组作为参数
* 若该数组中第一个元素不是基本函数则throw Error
* 返回一个objElement

### Maintainer
主要的

## 类型

### 闭包Closure
{
	arg: String
	code: String
	env: Zone
}

### 基本函数Function
{
	type: String
	fun: Function
}

### 任务Mission
{
	closure: Closure
	callback: function
}