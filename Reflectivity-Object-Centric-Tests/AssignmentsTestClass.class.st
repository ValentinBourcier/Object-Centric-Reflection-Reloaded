Class {
	#name : #AssignmentsTestClass,
	#superclass : #Object,
	#instVars : [
		'result',
		'a',
		'b'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #operation }
AssignmentsTestClass >> assignment1 [
	b:= 3.
	a:= 2.
	^ a + b
]

{ #category : #operation }
AssignmentsTestClass >> assignment2 [
	b:= 2.
	^ 3 - b.
]

{ #category : #operation }
AssignmentsTestClass >> methodsWithAssignments [
	a:= self assignment1.
	b:= self assignment2.
 	result:= 2.
	result:=  a + b.
	^ result.
]

{ #category : #operation }
AssignmentsTestClass >> predefinedAddition [

	a := 4.
	b := 6.
	result := a + b.
	^ result
]

{ #category : #operation }
AssignmentsTestClass >> reassignmentVariable [

	result := 7.
	result := 10.
	^ result
]
