"
Class to test assignmentes and messages sends
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	result:		<Object>
	var1:		<Object>
	var2:		<Object>


    Implementation Points
"
Class {
	#name : #TestClass,
	#superclass : #Object,
	#instVars : [
		'result',
		'var1',
		'var2'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #operation }
TestClass >> assignment1 [
	var2:= 3.
	var1:= 2.
	^ var1 + var2
]

{ #category : #operation }
TestClass >> assignment2 [
	var2:= 2.
	^ 3 - var2.
]

{ #category : #operation }
TestClass >> methodsWithAssignments [
	var1:= self assignment1.
	var2:= self assignment2.
 	result:= 2.
	result:=  var1 + var2.
	^ result.
]

{ #category : #operation }
TestClass >> onlyAssignment [

	var2 := 2.
	var1 := 9
]

{ #category : #operation }
TestClass >> onlyAssignmentResult [

	result := var1 + var2
]

{ #category : #operation }
TestClass >> predefinedAddition [

	var1 := 4.
	var2 := 6.
	result := var1 + var2.
	^ result
]

{ #category : #operation }
TestClass >> reassignmentVariable [

	result := 7.
	result := 10.
	^ result
]

{ #category : #accessing }
TestClass >> result [

	^ result
]

{ #category : #accessing }
TestClass >> result: anObject [

	result := anObject
]

{ #category : #operation }
TestClass >> resultAssignment [

	result := var1
]

{ #category : #operation }
TestClass >> selfAssignment [

	var2 := var1 + 2.
	var1 := var1 + 1.
	result := var1 +  var2
]

{ #category : #operation }
TestClass >> sendingMethods [

	result := var1.
	self var1SimpleAsssignment.
	self var2SimpleAsssignment
]

{ #category : #accessing }
TestClass >> var1 [

	^ var1
]

{ #category : #accessing }
TestClass >> var1: anObject [

	var1 := anObject
]

{ #category : #operation }
TestClass >> var1SimpleAsssignment [
	var1 := 7
]

{ #category : #accessing }
TestClass >> var2 [

	^ var2
]

{ #category : #accessing }
TestClass >> var2: anObject [

	var2 := anObject
]

{ #category : #operation }
TestClass >> var2Assignment [

	var2 := var1
]

{ #category : #operation }
TestClass >> var2SimpleAsssignment [

	var2 := self var2 * 2
]
