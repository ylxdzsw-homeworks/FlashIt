Developer Handbook
==================
##风格
###类型系统
本项目不使用prototype和其它强制性的类继承和类型判断，全部采用鸭子类型。
“类”在本项目中表现为一个闭包，类的构造函数等价于类本身

##模块


## 类型

### 闭包Closure
{
	arg: Array
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