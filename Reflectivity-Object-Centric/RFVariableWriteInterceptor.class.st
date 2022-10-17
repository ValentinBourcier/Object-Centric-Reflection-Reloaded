Class {
	#name : #RFVariableWriteInterceptor,
	#superclass : #RFStrategyInterceptor,
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #execution }
RFVariableWriteInterceptor >> execute: aOperation [

	^ metaObject linkInsteadAssignment: aOperation
]

{ #category : #override }
RFVariableWriteInterceptor >> execute: aName withValue: aValue [

	^ metaObject linkInsteadAssignment: aName withValue: aValue
]
