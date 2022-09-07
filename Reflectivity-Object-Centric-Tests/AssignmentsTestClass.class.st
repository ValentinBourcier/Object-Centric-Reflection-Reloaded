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

{ #category : #accessing }
AssignmentsTestClass >> a [

	^ a
]

{ #category : #accessing }
AssignmentsTestClass >> a: anObject [

	a := anObject
]

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

{ #category : #accessing }
AssignmentsTestClass >> b [

	^ b
]

{ #category : #accessing }
AssignmentsTestClass >> b: anObject [

	b := anObject
]

{ #category : #operation }
AssignmentsTestClass >> bAssignment [

	b := a
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
AssignmentsTestClass >> onlyAssignment [

	b := 2.
	a := 9
]

{ #category : #operation }
AssignmentsTestClass >> onlyAssignmentResult [

	result := a + b
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

{ #category : #accessing }
AssignmentsTestClass >> result [

	^ result
]

{ #category : #accessing }
AssignmentsTestClass >> result: anObject [

	result := anObject
]

{ #category : #operation }
AssignmentsTestClass >> resultAssignment [

	result := a
]

{ #category : #operation }
AssignmentsTestClass >> selfAssignment [

	b := a + 2.
	a := a + 1.
	result := a + b
]

{ #category : #operation }
AssignmentsTestClass >> selfAssignmentSingle [
	a := 1.
]
