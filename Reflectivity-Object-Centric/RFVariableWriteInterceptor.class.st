Class {
	#name : #RFVariableWriteInterceptor,
	#superclass : #RFStrategyInterceptor,
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #override }
RFVariableWriteInterceptor >> execute: aName withValue: aValue [

	^ metaObject linkInsteadAssignment: aName withValue: aValue
]
