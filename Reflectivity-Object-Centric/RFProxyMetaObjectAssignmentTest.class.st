"
I represent a implementation of MetaObject exclusively for assignments
"
Class {
	#name : #RFProxyMetaObjectAssignmentTest,
	#superclass : #RFProxyMetaObject,
	#instVars : [
		'logger'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> linkAfterAssignment: operation [

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: operation variable name.
	logger newValue: operation assignedValue.
	logger oldValue: (operation variable read: operation object).

	super linkAfterAssignment: operation
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> linkBeforeAssignment: operation [

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: operation variable name.
	logger newValue: operation assignedValue.
	logger oldValue: (operation variable read: operation object).

	super linkBeforeAssignment: operation
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> linkInsteadAssignment: operation [

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: operation variable name.
	logger newValue: operation assignedValue.
	logger oldValue: (operation variable read: operation object).

	super linkInsteadAssignment: operation
]

{ #category : #accessing }
RFProxyMetaObjectAssignmentTest >> logger [

	^ logger
]

{ #category : #accessing }
RFProxyMetaObjectAssignmentTest >> logger: anObject [

	logger := anObject
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> receiveAssignment: aVariable withOldValue: aOldValue withValue: aValue [
	self class log:
		'METAOBJECTTEST receive Variable: ' , aVariable printString
		, ' with Value: ' , aValue printString, '  old Value: ', aOldValue printString.
	logger := RFAssignmentMetaObjectInterceptor  new.
	logger variable: aVariable.
	logger newValue: aValue.
	logger oldValue: aOldValue.

]
