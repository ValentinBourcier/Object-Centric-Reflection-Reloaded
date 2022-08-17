Class {
	#name : #RFAssignmentsStoring,
	#superclass : #Object,
	#instVars : [
		'assignments',
		'allAssignmentsBefore',
		'allAssignmentsAfter',
		'allAssignmentsInstead'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #adding }
RFAssignmentsStoring >> addAllAssignmentsAfter: aBlock [

	self allAssignmentsAfter add: aBlock.
]

{ #category : #adding }
RFAssignmentsStoring >> addAllAssignmentsBefore: aBlock [

	self allAssignmentsBefore add: aBlock.
]

{ #category : #accessing }
RFAssignmentsStoring >> allAssignmentsAfter [

	^ allAssignmentsAfter  ifNil: [ allAssignmentsAfter := LinkedList   new ]
]

{ #category : #accessing }
RFAssignmentsStoring >> allAssignmentsBefore [

	^ allAssignmentsBefore  ifNil: [ allAssignmentsBefore := LinkedList  new ] 
]

{ #category : #accessing }
RFAssignmentsStoring >> allAssignmentsInstead [

	^ allAssignmentsInstead
]

{ #category : #accessing }
RFAssignmentsStoring >> allAssignmentsInstead: anObject [

	allAssignmentsInstead := anObject
]

{ #category : #accessing }
RFAssignmentsStoring >> assignments [

	^ assignments ifNil: [ assignments := (Dictionary new)  ]
]

{ #category : #accessing }
RFAssignmentsStoring >> assignments: anObject [

	assignments := anObject
]
