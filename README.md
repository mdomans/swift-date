<h1>swift-date</h1>
==========

Easy date manipulation for Swift language

* state of library: **experimental**

## Why implement a Date type, we have NSDate? 

Yes. And it's a very good API, but it makes simple, often performed date computations relatively cumbersome, especially for new developers.

This framework provides a set of simple types for simple date and time computations such as:

* calculating time deltas (how much time from **Date** to **Date**)
* offseting dates by certain amount of time
* parsing **String** into **Date**
* syntax sugar for readable **Date** manipulation

e.g.

```
var firstDate = Date() // now
var seconddate = Date(dateString: "2014-03-10 12:00:00 PST")
XCTAssertTrue(secondDate.year, 2014) 
XCTAssertTrue(secondDate.timezone, NSTimeZone.localTimeZone())
XCTAssertFalse(firstDate == secondDate, "simple object comparison")
var timeDelta = firstDate - secondDate // time delta as object
var someTime:Date = Date() - timeDelta // simple date offsetting
// or even simpler
var anotherTime = Date(dateString: "2014-03-10 12:00:00 PST") - TimeDelta(days:2)
XCTAssertEqual(anotherTime.day, 8, "very simple, isn't it")
```

## Instalation

Pull from github, add as a framework and voila. For the time being this is the only way to install this lib, though I'll add it to CocoaPods as soon as I consider it **alpha**, currently this is **experimental**.

## Contributing

Open a pull request, add a branch and you're good to go.

## Where to get help & contributors

Currently only me, hit me at **mdomans@gmail.com**

