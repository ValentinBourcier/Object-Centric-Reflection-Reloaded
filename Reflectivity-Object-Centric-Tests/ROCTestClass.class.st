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
	#name : #ROCTestClass,
	#superclass : #Object,
	#instVars : [
		'result',
		'var1',
		'var2',
		'collection',
		'counter'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #operation }
ROCTestClass >> add: aValue [

	var1 := aValue
]

{ #category : #operation }
ROCTestClass >> assigningValues [

	self var1SimpleAsssignment.
	var1 := self returningValue.
	var2 := self returningValue + 2.
	^ self returningValue + 1
]

{ #category : #operation }
ROCTestClass >> assignment1 [
	var2:= 3.
	var1:= 2.
	^ var1 + var2
]

{ #category : #operation }
ROCTestClass >> assignment2 [
	var2:= 2.
	^ 3 - self var2.
]

{ #category : #accessing }
ROCTestClass >> collection [

	^ collection
]

{ #category : #accessing }
ROCTestClass >> collection: anObject [

	collection := anObject
]

{ #category : #accessing }
ROCTestClass >> counter [

	^ counter
]

{ #category : #accessing }
ROCTestClass >> counter: anObject [

	counter := anObject
]

{ #category : #accessing }
ROCTestClass >> messageSendOtherObjects [

	self add: 1.
	collection add: 2.
	self add: 3.
	collection add: 4
]

{ #category : #operation }
ROCTestClass >> methodsWithAssignments [
	var1:= self assignment1.
	var2:= self assignment2.
 	result:= 2.
	result:=  var1 + var2.
	^ result.
]

{ #category : #operation }
ROCTestClass >> onlyAssignment [

	var2 := 2.
	var1 := 9
]

{ #category : #operation }
ROCTestClass >> onlyAssignmentResult [

	result := var1 + var2
]

{ #category : #operation }
ROCTestClass >> predefinedAddition [

	var1 := 4.
	var2 := 6.
	result := var1 + var2.
	^ result
]

{ #category : #operation }
ROCTestClass >> reassignmentVariable [

	result := 7.
	result := 10.
	^ result
]

{ #category : #accessing }
ROCTestClass >> result [

	^ result
]

{ #category : #accessing }
ROCTestClass >> result: anObject [

	result := anObject
]

{ #category : #operation }
ROCTestClass >> resultAssignment [

	result := var1
]

{ #category : #operation }
ROCTestClass >> returningValue [

	^ 2
]

{ #category : #operation }
ROCTestClass >> selfAssignment [

	var2 := var1 + 2.
	var1 := var1 + 1.
	result := var1 +  var2
]

{ #category : #operation }
ROCTestClass >> sendingMethods [

	result := var1.
	self var1SimpleAsssignment.
	self var1SimpleAsssignment
]

{ #category : #accessing }
ROCTestClass >> var1 [

	^ var1
]

{ #category : #accessing }
ROCTestClass >> var1: anObject [

	var1 := anObject
]

{ #category : #operation }
ROCTestClass >> var1SimpleAsssignment [
	var1 := 7
]

{ #category : #accessing }
ROCTestClass >> var2 [

	^ var2
]

{ #category : #accessing }
ROCTestClass >> var2: anObject [

	var2 := anObject
]

{ #category : #operation }
ROCTestClass >> var2Assignment [

	var2 := var1
]

{ #category : #operation }
ROCTestClass >> var2SimpleAsssignment [

	var2 := self var2 * 2
]

{ #category : #operation }
ROCTestClass >> variablesReadandAssignment [

	result := var1 + var2.
	self var2.
	self var1.
	^ self result
]

{ #category : #operation }
ROCTestClass >> variablesReadandAssignmentToOneVariable [

	result := var1.
	self var2.
	^ var1
]
