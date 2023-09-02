---
title: "golang面试题"
date: 2023-01-31T17:20:31+08:00
comments: true
id: go-interview
categories:
  - 
tags: [go,面试]
---

# 记录面试遇到的一个有趣的题

## 问题
写出下面的输出结果和原因
```go
func main() {
	runtime.GOMAXPROCS(1)
	count := 10
	wg := sync.WaitGroup{}
	wg.Add(count * 2)
	for i := 0; i < count; i++ {
		go func() {
			fmt.Printf("[%d]", i)
			wg.Done()
		}()
	}
	for i := 0; i < count; i++ {
		go func(i int) {
			fmt.Printf("-%d-", i)
			wg.Done()
		}(i)
	}
	wg.Wait()
}
```

## GPT回答
这段代码的输出结果可能会是不确定的，并且与你的预期可能不一致。这是因为你在两个不同的`for`循环中启动了一系列的goroutine，这些goroutine访问了共享的变量`i`，但是它们在不同的时间点执行，因此无法确定哪个goroutine会首先访问`i`。

具体来说，以下是可能的输出结果之一：

```
[10][10][10][10][10][10][10][10][10][10]--0---1---2---3---4---5---6---7---8---9--
```

这个结果中，所有的`[10]`都表示第一个`for`循环创建的goroutine都访问了`i`的最终值10。然后，第二个`for`循环创建的goroutine按照它们的顺序输出了0到9。

要解决这个问题，你可以将循环变量`i`作为参数传递给goroutine，以便每个goroutine都有自己的`i`的副本。例如：

```go
func main() {
    runtime.GOMAXPROCS(1)
    count := 10
    wg := sync.WaitGroup{}
    wg.Add(count * 2)
    for i := 0; i < count; i++ {
        go func(i int) {
            fmt.Printf("[%d]", i)
            wg.Done()
        }(i)
    }
    for i := 0; i < count; i++ {
        go func(i int) {
            fmt.Printf("-%d-", i)
            wg.Done()
        }(i)
    }
    wg.Wait()
}
```

通过将`i`作为参数传递给goroutine，你可以确保每个goroutine都使用了自己的`i`值，而不是竞争访问共享的`i`变量。这样，你的输出将会更符合预期。

## 如果runtime.GOMAXPROCS(2)，输出结果是什么，为什么？
GPT回答: 

如果你将`runtime.GOMAXPROCS(2)`设置为2，那么Go程序将允许同时运行两个操作系统线程上的goroutines。这会导致goroutines并发执行，但仍然存在竞争条件。

根据你的代码，以下是可能的输出结果之一：

```
[10][10]-0--[10]-1--[10]-2--[10]-3--[10]-4--[10]-5--[10]-6--[10]-7--[10]-8--[10]-9--
```

在这个输出中，`[10]`表示第一个`for`循环创建的goroutine都访问了`i`的最终值10。然后，第二个`for`循环创建的goroutine按照它们的顺序输出0到9，但与第一个`for`循环创建的goroutine交织在一起。这是因为你将GOMAXPROCS设置为2，允许两个goroutine并发运行。

但是，请注意，仍然存在竞争条件。这意味着多个goroutines可以同时访问`i`，并且由于竞争条件，输出的结果可能因运行时机而异。如果你需要确保goroutines安全地访问`i`，你应该使用互斥锁（mutex）或通道来同步它们的访问。否则，你不能保证输出的一致性。

## 为什么是10，而不是9?
GPT回答:

这是因为 `i` 变量在第一个 `for` 循环中被多个 goroutine 共享，并且 goroutines 的执行速度可能比 `for` 循环更快。**当 `for` 循环结束后，`i` 变量的值会变成 10，因为循环条件 `i < count` 不再满足时，`i` 自增到了 10** 。

让我详细解释一下为什么会这样：

1. `i` 的初始值是0，然后第一个 goroutine 启动并开始执行匿名函数，但在执行 `fmt.Printf("[%d]", i)` 之前，可能会有其他 goroutine 开始执行。

2. 当其他 goroutine 执行时，`for` 循环会继续迭代，`i` 会自增。这样，`i` 变成了1，然后2，然后3，以此类推，直到变成10。

3. 当第一个 goroutine执行 `fmt.Printf("[%d]", i)` 时，`i` 的值已经变成了10，因为 `i` 在匿名函数内部是共享的，而不是被复制。

这就是为什么第一个 `for` 循环中的所有 goroutine 打印的值都是10，而不是9。这个问题可以通过将 `i` 的值复制到匿名函数的参数中来避免，以确保每个 goroutine 使用的是自己的 `i` 值。