Class {
	#name : #RFAssignmentInterceptor,
	#superclass : #Object,
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #deprecated }
RFAssignmentInterceptor >> execute: receiver variable: variable value: value newValue: newValue [

	<debuggerCompleteToSender>
	RFProxyMetaObject log:
		'Receiver: ' , receiver printString , '  Variable: '
		, variable printString , '  Value: ' , value printString
		, '  NewValue: ' , newValue printString.
	
	^ metaObject receiveAssignment: variable withOldValue: value  withValue: newValue.
]

{ #category : #execution }
RFAssignmentInterceptor >> executeAfter: operation [

	<debuggerCompleteToSender>
	^ metaObject linkAfterAssignment: operation
]

{ #category : #execution }
RFAssignmentInterceptor >> executeBefore: operation [

	<debuggerCompleteToSender>
	^ metaObject linkBeforeAssignment: operation
]

{ #category : #execution }
RFAssignmentInterceptor >> executeInstead: operation [

	<debuggerCompleteToSender>

	^ metaObject linkInsteadAssignment: operation
]

{ #category : #accessing }
RFAssignmentInterceptor >> metaObject [

	^ metaObject
]

{ #category : #accessing }
RFAssignmentInterceptor >> metaObject: anObject [

	metaObject := anObject
]
