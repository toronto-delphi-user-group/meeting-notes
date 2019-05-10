**Presenter: Brian Muegge**

Interfaces are one of those Delphi features that you may not think you need, but once you get comfortable using them, you might wonder how you ever got by without them. In this session, we'll start by looking at the differences between interfaces and classes, and how they relate to one another. We'll discuss some situations in which using interfaces may be preferable to using regular Delphi classes. We'll examine the pros and cons of automatic reference counting by looking at how interfaces are implemented in the Delphi run-time library. Finally, we'll look at how interfaces can be used with other Delphi features such as threads, generics, and run-time type information, including benefits and potential pitfalls.

**Demo 1**

Implement interfaces using descendants of TInterfacedObject
Use the Supports method to determine the interfaces implemented by a class
Use the "as" operator or the Supports method to determine the interfaces implemented by an instance of a class

**Demo 2**

Demonstrate automatic reference counting in TInterfacedObject

**Demo 3**

Demonstrate potential pitfall when using automatic reference counting
Parent and child objects are not destroyed because they retain references to each other

**Demo 4**

Demonstrate one way to get around the reference counting problem shown in Demo 3
The child object accesses the parent object through a function call rather than an interface reference
This can be used in older versions of Delphi that do not support the [weak] attribute (see Demo 5)

**Demo 5**

Demonstrate another way to get around the reference counting problem shown in Demo 3
This example is the same as Demo 4, but uses the [weak] attribute instead of a function call
Only newer versions of Delphi support the [weak] attribute for all compilers

**Demo 6**

Demonstrate interface aggregation
The interface is implemented by a descendent of TAggregatedObject that is contained in an instance of TInterfacedObject
Re-use of the inner object can reduce code duplication

**Demo 7**

Demonstrate how to disambiguate between implementations when implementing interfaces that contain identical methods

**Demo 8**

Use runtime type information, IInvokable and TVirtualInterface to bind an implementation to an interface at runtime

**Demo 9**

Demonstrate a potential pitfall when using interfaces with generics
The Supports method used the GUID signature to identify an interface, so it can't distinguish between IList<string> and IList<Integer>
The Spring4d framework (https://bitbucket.org/sglienke/spring4d) is required to compile this demo
