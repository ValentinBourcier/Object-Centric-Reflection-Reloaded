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
RFProxyMetaObjectAssignmentTest >> linkAfterAssignment: aName withValue: aValue [

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: aName.
	logger newValue: aValue.
	logger oldValue: aValue.

	super linkAfterAssignment: aName withValue: aValue
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> linkBeforeAssignment: aName withValue: aValue [

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: aName.
	logger newValue: aValue.
	logger oldValue: aValue.

	super linkBeforeAssignment: aName withValue: aValue
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> linkInsteadAssignment: operation [

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: operation variable name.
	logger newValue: operation assignedValue.
	logger oldValue: (operation variable read: operation object).

	super linkInsteadAssignment: operation
]

{ #category : #'message passing' }
RFProxyMetaObjectAssignmentTest >> linkInsteadAssignment: aName withValue: aValue [

	logger := RFAssignmentMetaObjectInterceptor new.
	logger variable: aName.
	logger newValue: aValue.
	logger oldValue: aValue.

	super linkInsteadAssignment: aName withValue: aValue
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
