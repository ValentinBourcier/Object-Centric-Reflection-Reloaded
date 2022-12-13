# Object Centric Reflection a tutorial:

## What it is?

With Object-centric reflection we can install one or more instructions to an specific instance of an Object. This is because with Object Centric reflection we can install a meta-object to every object of the system with the instruction "mop". This mean that I can have many instances of a Class and install a different meta-object to each one.

![MetaObject protocol](/images/mop.png)


The instruction(s) that we set for an specific instance of a Class are independent from the other instances. This mean that I can set several instruction to one instance without affecting the execution of the other instances. These instructions are executed according the installation instruction that we define. This is because we can define where is going to be executed the instruction(s) and in what execution order (which instruction is before or after).

Is important to mention that it exist 3 object-centric operations and that we can define the instructions in base of that operations. The operations are (consider O as a target object):

- State access: This operation has 2 parts:
    - Variable Read:  variables of O are read.
    - Variable Write:  variables of O are written.
- Message Send: O tells an object to execute a method
- Message Receive:  an object tells O to execute a method

## Installation

If you use the object-centric reflection reloaded image, you can skip this part and start the tutorial. Else, follow installation instructions here https://github.com/DanielCamSan/Object-Centric-Reflection-Reloaded.

Or install it running the next code in a playground.
```Smalltalk
Metacello new
    baseline: 'ObjectCentricReflectionReloaded';
    repository: 'github://DanielCamSan/Object-Centric-Reflection-Reloaded:main';
    load.
```

## Usage 
The API to configure the instructions have the next structure:

    execution order + where + object-centric-operation + block

In that context we have the next API available.

    beforeAnyVariableReadDo: []
    beforeAnyAssignmentDo: []
    beforeAnyMessageSendDo: []
    beforeVariableRead: #aVariable Do: []
    beforeAssignmentTo: #aVariable Do: []
    beforeMessageSend: #aMessage Do: []

    insteadAnyVariableReadDo: []
    insteadAnyAssignmentDo: []
    insteadAnyMessageSendDo: []
    insteadVariableRead: #aVariable Do: []
    insteadAssignmentTo: #aVariable Do: []
    insteadMessageSend: #aMessage Do: []

    afterAnyVariableReadDo: []
    afterAnyAssignmentDo: []
    afterAnyMessageSendDo: []
    afterVariableRead: #aVariable Do: []
    afterAssignmentTo: #aVariable Do: []
    afterMessageSend: #aMessage Do: []

## Tutorial

For the tutorial you can go to the package Reflectivity-Object-Centric-Tests-example inside you have the class ROCBox and ROCBoxTest.

The class ROCBox only have 3 instances variables (var 1, var2 and collection) and different methods that we are going to use in order to configure our instructions. Is important to watch that the class ROCBox have a initialize method that gives default values to the instances variables.

Now we can access to the class ROCBoxTest, inside we have the simple tests for every object centric operation. Lets take a look in the protocol "test - variable - read". Now select the method testSimpleVariableRead.
```Smalltalk
testSimpleVariableRead
1	| aBox counter |
2	counter := 0.
3	aBox := ROCBox new.
4	aBox mop beforeVariableRead: #var1 do: [ counter := counter + 1 ].
5	aBox variablesReadandAssignment.
6	self assert: counter equals: 1
```

Here we can see how to configure and add one instruction to an object.
First we need to create the instance of the object (line 3). Then we have to enable the meta-object protocol in order to set the instruction. We can do that with the method "mop" (line 4). Finally we have to use the API to set the instructions (line 4). Now every time that the variable "var1" is read the counter is going to be incremented in 1.
In line 5 we are executing the method "variablesReadandAssignment", the implementation is below.

```Smalltalk
variablesReadandAssignment
1	var2 := var1 + var2.
2	self var2.
3	self var1.
4	^ self var1
```

So now we are sure that we are only reading the Var1 just one time and the test is working correct. We increment the counter just one time.



## Benefits

* We can define to do whatever we want inside the blocks. This is super useful because we can do multiple actions inside. We can see that in the next code. In the code we have to focus in lines 4-7 that is where we are setting multiple actions to do in the same block.

```Smalltalk
testSimpleAnyVariableReadWithMethodInTheBlock
1	| aBox counter |
2	counter := 0.
3	aBox := ROCBox new.
4	aBox mop beforeAnyVariableReadDo: [ 
5		counter := counter + 1.
6		aBox addCollection.
7		aBox var2: 3 ].
8	aBox variablesReadandAssignment.
9	self assert: counter equals: 2.
10	self assert: aBox var2 equals: 3.
11	self
12		assert: aBox collection
13		equals: (OrderedCollection withAll: #( 0 0 0 3 ))
```


* The instructions that we define are independent. This mean that they are just for that particular instance of the Object. We can see that in the code below. in lines 3 and 4 we are creating different instance of the same object, in lines 5-8 we are installing the instruction to one of them. Finally at line 9 we are doing a method for the other instance, and we can see that the lines inside the instruction are not executed because is not related to his instance.

```Smalltalk
testSimpleAnyVariableReadDifferentObjects
1	| aBox bBox counter |
2	counter := 0.
3	aBox := ROCBox new.
4	bBox := ROCBox new.
5	aBox mop beforeAnyVariableReadDo: [ 
6		counter := counter + 1.
7		aBox addCollection.
8		aBox var2: 3 ].
9	bBox variablesReadandAssignment.
10	self assert: counter equals: 0.
11	self assert: aBox var2 equals: 0.
12	self assert: aBox collection equals: OrderedCollection new
```




We can set more than one instruction related to the same instance of the object. We can see that in the code of below. In lines 5 and 6 we are setting different instructions to the same instance of the object. When we executed the line 7 is going to execute the instruction in the correct execution order in the order that where set.

```Smalltalk
testSimpleVariableReadMoreThanOneInstruction
1	| aBox counter counter2|
2	counter := 0.
3	counter2 := 0.
4	aBox := ROCBox new.
5	aBox mop beforeVariableRead: #var1 do: [ counter := counter + 1 ].
6	aBox mop beforeVariableRead: #var2 do: [ counter2 := counter2 + 1 ].
7	aBox variablesReadandAssignment.
8	self assert: counter equals: 1.
9	self assert: counter2 equals: 1
```

## Things to consider

A thing that we have to consider is that when we set an instruction in the execution order instead we have to return. a value that fit in the right context, lets analyze this in the next example:

```Smalltalk
testSimpleVariableReadInstead
1	| aBox counter |
2	counter := 0.
3	aBox := ROCBox new.
4	aBox mop insteadVariableRead: #var2 do: [ counter := counter + 1. 7 ].
5	aBox addCollectionSumOfValues.
6	self assert: counter equals: 1.
7	self
8		assert: aBox collection
9		equals: (OrderedCollection withAll: #( 7 ))



addCollectionSumOfValues
1	collection add: var1 + var2

```

The important part is that inside the block in line 4 we have to return a value that can be analyzed in the code where is replaced. In the code we can see that the block is going to be executed instead of "var2", but if we go into the method "addCollectionSumOfValues" we can see that the var 1 is sending the "+" operation to the result of var2. This is why we have to return in the block something that understand the "+". In this case we return 7.

## Conclusion

We have seen and practiced different scenarios for object-centric reflection. We used a simple example to show the benefits of this tool. However is possible to do much more big things with them. There are useful in order to execute personalized blocks during the run time. We can define that the block executed anything that we want. Just we need to be careful about the returning values inside the blocks.

