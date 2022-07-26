Class {
	#name : #RFAssignmentInterceptor,
	#superclass : #Object,
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #execution }
RFAssignmentInterceptor >> execute: receiver variable: variable value: value newValue: newValue [

	<debuggerCompleteToSender>
	RFProxyMetaObject log:
		'Receiver: ' , receiver printString , '  Variable: '
		, variable printString , '  Value: ' , value printString
		, '  NewValue: ' , newValue printString.
	
	^ metaObject receiveAssignment: variable withOldValue: value  withValue: newValue.
]

{ #category : #accessing }
RFAssignmentInterceptor >> metaObject [

	^ metaObject
]

{ #category : #accessing }
RFAssignmentInterceptor >> metaObject: anObject [

	metaObject := anObject
]
