swift-date
==========

A Date type for Swift language

## why implement a Date type, we have NSDate? 

Yes. And it's a very good API, but it makes simple, often performed date computations relatively cumbersome, especially for new developers.

This framework provides a set of simple types for simple date and time computations such as:

* calculating time deltas (how much time from **Date** to **Date**)
* offseting dates by certain amount of time
* parsing **String** into **Date**
* syntax sugar for readable **Date** manipulation