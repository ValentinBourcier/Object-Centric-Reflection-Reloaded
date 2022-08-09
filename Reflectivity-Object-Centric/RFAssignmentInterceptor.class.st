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

{ #category : #execution }
RFAssignmentInterceptor >> executeAfter: operation [

	<debuggerCompleteToSender>
	RFProxyMetaObject log:
		'AFTERReceiver: ' , operation variable owningClass printString
		, '  Variable: ' , operation variable name , '  Value: '
		, (operation variable read: operation object) printString
		, '  NewValue: ' , operation assignedValue printString.


	^ metaObject afterAssignment: operation
]

{ #category : #execution }
RFAssignmentInterceptor >> executeBefore: operation [

	<debuggerCompleteToSender>
	RFProxyMetaObject log:
		'BEFOREReceiver: ' , operation variable owningClass printString
		, '  Variable: ' , operation variable name , '  Value: '
		, (operation variable read: operation object) printString
		, '  NewValue: ' , operation assignedValue printString.


	^ metaObject beforeAssignment: operation
]

{ #category : #execution }
RFAssignmentInterceptor >> executeInstead: operation [

	<debuggerCompleteToSender>
	RFProxyMetaObject log:
		'INSTEADReceiver: ' , operation variable owningClass printString
		, '  Variable: ' , operation variable name , '  Value: '
		, (operation variable read: operation object) printString
		, '  NewValue: ' , operation assignedValue printString.

	^ metaObject insteadAssignment: operation
]

{ #category : #accessing }
RFAssignmentInterceptor >> metaObject [

	^ metaObject
]

{ #category : #accessing }
RFAssignmentInterceptor >> metaObject: anObject [

	metaObject := anObject
]
