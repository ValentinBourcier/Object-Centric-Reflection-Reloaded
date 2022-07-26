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
