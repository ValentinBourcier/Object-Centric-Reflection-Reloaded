Class {
	#name : #RFAssignmentInterceptorTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignmentInterceptorTest >> testExecute [

	| b proxy metaobject  |
	b := Bub new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignmentTest.
	self assert: metaobject logger variable equals: #var1.
	self assert: metaobject logger newValue equals: 16.

]

{ #category : #'as yet unclassified' }
RFAssignmentInterceptorTest >> testExecuteAssignmentsWithMethods [

	| b proxy metaobject  |
	b := AssignmentsTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b methodsWithAssignments.
	self assert: metaobject logger variable equals: #result.
	self assert: metaobject logger newValue equals: 6.

]

{ #category : #tests }
RFAssignmentInterceptorTest >> testExecuteReAssignmentVariable [

	| b proxy metaobject  |
	b := AssignmentsTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b reassignmentVariable .
	self assert: metaobject logger variable equals: #result.
	self assert: metaobject logger newValue equals: 10.

]

{ #category : #tests }
RFAssignmentInterceptorTest >> testExecuteVariousAssignments [

	| b proxy metaobject  |
	b := AssignmentsTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b predefinedAddition.
	self assert: metaobject logger variable equals: #result.
	self assert: metaobject logger newValue equals: 10.

]
