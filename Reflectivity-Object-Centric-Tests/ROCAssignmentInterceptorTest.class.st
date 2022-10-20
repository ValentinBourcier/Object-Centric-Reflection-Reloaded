Class {
	#name : #ROCAssignmentInterceptorTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #tests }
ROCAssignmentInterceptorTest >> testExecute [

	| b proxy metaobject  |
	b := ROCBottom new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b assignmentTest.
	self assert: metaobject logger variable equals: #var1.
	self assert: metaobject logger newValue equals: 16.

]

{ #category : #'as yet unclassified' }
ROCAssignmentInterceptorTest >> testExecuteAssignmentsWithMethods [

	| b proxy metaobject  |
	b := ROCTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b methodsWithAssignments.
	self assert: metaobject logger variable equals: #result.
	self assert: metaobject logger newValue equals: 6.

]

{ #category : #tests }
ROCAssignmentInterceptorTest >> testExecuteReAssignmentVariable [

	| b proxy metaobject  |
	b := ROCTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b reassignmentVariable .
	self assert: metaobject logger variable equals: #result.
	self assert: metaobject logger newValue equals: 10.

]

{ #category : #tests }
ROCAssignmentInterceptorTest >> testExecuteVariousAssignments [

	| b proxy metaobject  |
	b := ROCTestClass  new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b predefinedAddition.
	self assert: metaobject logger variable equals: #result.
	self assert: metaobject logger newValue equals: 10.

]
