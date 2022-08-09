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
RFProxyMetaObjectAssignmentTest >> afterAssignment: operation [

	self class log:
		'AFTERMETAOBJECTTESTReceiver: ' , operation variable owningClass printString
		, '  Variable: ' , operation variable name , '  Value: '
		, (operation variable read: operation object) printString
		, '  NewValue: ' , operation assignedValue printString.

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: operation variable name.
	logger newValue: operation assignedValue.
	logger oldValue: (operation variable read: operation object).
	
	super afterAssignment: operation
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> beforeAssignment: operation [

	self class log:
		'BEFOREMETAOBJECTTESTReceiver: ' , operation variable owningClass printString
		, '  Variable: ' , operation variable name , '  Value: '
		, (operation variable read: operation object) printString
		, '  NewValue: ' , operation assignedValue printString.

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: operation variable name.
	logger newValue: operation assignedValue.
	logger oldValue: (operation variable read: operation object).
	
	super beforeAssignment: operation
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> insteadAssignment: operation [

	self class log:
		'INSTEADMETAOBJECTTESTReceiver: ' , operation variable owningClass printString
		, '  Variable: ' , operation variable name , '  Value: '
		, (operation variable read: operation object) printString
		, '  NewValue: ' , operation assignedValue printString.

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: operation variable name.
	logger newValue: operation assignedValue.
	logger oldValue: (operation variable read: operation object).
	
	super insteadAssignment: operation
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
