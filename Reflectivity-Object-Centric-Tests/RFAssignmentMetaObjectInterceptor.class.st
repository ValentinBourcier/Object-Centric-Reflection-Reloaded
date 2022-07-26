Class {
	#name : #RFAssignmentMetaObjectInterceptor,
	#superclass : #Object,
	#instVars : [
		'variable',
		'oldValue',
		'newValue'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> newValue [

	^ newValue
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> newValue: anObject [

	newValue := anObject
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> oldValue [

	^ oldValue
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> oldValue: anObject [

	oldValue := anObject
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> variable [

	^ variable
]

{ #category : #accessing }
RFAssignmentMetaObjectInterceptor >> variable: anObject [

	variable := anObject
]
