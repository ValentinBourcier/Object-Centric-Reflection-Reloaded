Class {
	#name : #ROCProxyInstrumenterTest,
	#superclass : #TestCase,
	#instVars : [
		'instrumenter',
		'testObject'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #helpers }
ROCProxyInstrumenterTest >> receive: selector [
	^testObject perform: selector
]

{ #category : #tests }
ROCProxyInstrumenterTest >> setUp [
	super setUp.
	instrumenter := ROCProxyInstrumenter for: self.
	testObject := Object new
]

{ #category : #tests }
ROCProxyInstrumenterTest >> testBeForObject [
	
	instrumenter beForObject: testObject.
	self assert: instrumenter instrumentedObject identicalTo: testObject.
	self assert: instrumenter instrumentedClass identicalTo: testObject class.
	self assert: instrumenter instrumentedClass isAnonymous.
	self assert: instrumenter instrumentedClass superclass identicalTo: Object.
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testBuildSuperSendsChainFromSourceMethodToHighestMethodInClassHierarchy [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := ROCBottom >> #mWithSuper.
	targetMethod := ROCTop >> #mWithSuper.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: nil in: chain.	
	
	self assert: chain size equals: 2.
	self assert: chain first identicalTo: sourceMethod.
	self assert: chain last identicalTo: (ROCMiddle >> #mWithSuper).
	self assert: lastFoundMethod identicalTo: targetMethod

	
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testBuildSuperSendsChainFromSourceMethodToTargetMethod [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := ROCBottom >> #mWithSuper.
	targetMethod := ROCMiddle >> #mWithSuper.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: targetMethod in: chain.	
	
	self assert: chain size equals: 1.
	self assert: chain first identicalTo: sourceMethod.
	self assert: lastFoundMethod identicalTo: targetMethod

	
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testBuildSuperSendsChainFromSourceMethodToTargetMethodFailure [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := ROCBottom >> #superUpToMiddleHierarchy.
	targetMethod := ROCTop >> #superUpToMiddleHierarchy.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: targetMethod in: chain.	
	self deny: lastFoundMethod identicalTo: targetMethod
	

]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testCompileEmptySuperSendChain [

	self assertEmpty: (instrumenter compileSuperSendChain: #(  ))
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testCompileSuperSendChain [

	|chain compiledSelectors|
	testObject := ROCBottom new.
	instrumenter beForObject: testObject.
	 
	chain := {ROCBottom >> #mWithSuper. ROCMiddle >> #mWithSuper. ROCTop >> #mWithSuper  }.
	compiledSelectors := instrumenter compileSuperSendChain: chain.
	
	self assert: compiledSelectors size equals: chain size.
	self assert: compiledSelectors first equals: #mWithSuper.
	self assert: compiledSelectors second equals: #_2_mWithSuper.
	self assert: compiledSelectors third equals: #_3_mWithSuper.
	
	self assert: (instrumenter compiledSelectorsMap at: compiledSelectors first) equals: compiledSelectors second.
	self assert: (instrumenter compiledSelectorsMap at: compiledSelectors second) equals: compiledSelectors third.
	self should: [(instrumenter compiledSelectorsMap at: compiledSelectors third)] raise: KeyNotFound.
	
	self assert: (testObject class >> compiledSelectors first) ast body sourceCode equals: (ROCBottom >> #mWithSuper) ast body sourceCode.
	self assert: (testObject class >> compiledSelectors second) ast body sourceCode equals: (ROCMiddle >> #mWithSuper) ast body sourceCode.
	self assert: (testObject class >> compiledSelectors third) ast body sourceCode equals: (ROCTop >> #mWithSuper) ast body sourceCode.
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testCompileSuperSendChainWithoutSuper [

	|chain compiledSelectors|
	testObject := ROCBottom new.
	instrumenter beForObject: testObject.
	 
	chain := {ROCBottom >> #mWithSuper}.
	compiledSelectors := instrumenter compileSuperSendChain: chain.
	
	self assert: compiledSelectors size equals: chain size.
	self assert: compiledSelectors first equals: #mWithSuper.
	
	self assertEmpty: (instrumenter compiledSelectorsMap).
	
	self assert: (testObject class >> compiledSelectors first) sourceCode equals: (ROCBottom >> #mWithSuper) sourceCode
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testFindEmptySuperSendsChainFor [

	|method chain|	
	"Case 1: the method is not reachable from Bib instances"
	instrumenter beForObject: ROCMiddle new.
	method := ROCBottom >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assertEmpty: chain.
	
	"Case 2: the method is not reachable from Bub instances"
	instrumenter beForObject: ROCBottom new.
	method := ROCMiddle >> #redefineNoSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assertEmpty: chain
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testFindSuperSendsChainFor [

	|method chain|	
	
	instrumenter beForObject: ROCBottom new.
	
	"Case 1: the method is reachable from Bub instances but has no super calls"
	method := ROCMiddle >> #superUpToMiddleHierarchy.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 2.
	self assert: chain first identicalTo: (ROCBottom >> #superUpToMiddleHierarchy).
	self assert: chain last identicalTo: (ROCMiddle >> #superUpToMiddleHierarchy).
	
	"Case 2: the method is reachable from Bub instances and calls super up to Object"
	method := ROCMiddle >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 3.
	self assert: chain first identicalTo: (ROCBottom >> #mWithSuper).
	self assert: chain second identicalTo: (ROCMiddle >> #mWithSuper).
	self assert: chain last identicalTo: (ROCTop >> #mWithSuper).
	
	"Case 2 variant"
	method := ROCBottom >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 3.
	self assert: chain first identicalTo: (ROCBottom >> #mWithSuper).
	self assert: chain second identicalTo: (ROCMiddle >> #mWithSuper).
	self assert: chain last identicalTo: (ROCTop >> #mWithSuper).
]

{ #category : #tests }
ROCProxyInstrumenterTest >> testInstantiation [

	self assert: instrumenter metaObject identicalTo: self
]

{ #category : #tests }
ROCProxyInstrumenterTest >> testInstrumentedClass [

	instrumenter beForObject: testObject.
	self
		assert: instrumenter instrumentedClass
		identicalTo: testObject class
]

{ #category : #tests }
ROCProxyInstrumenterTest >> testInstrumentedMessages [
	|im|
	im := instrumenter instrumentedMessages .
	self assert: im size equals: 1.
	self assert: (im includes: #class).
]

{ #category : #'tests - method flattening' }
ROCProxyInstrumenterTest >> testIsMethodReachableInHierarchy [
	
	|method|
	instrumenter beForObject: ROCMiddle new.
	self assert: (instrumenter isClassReachableInHierarchy: ROCMiddle).
	
	method := ROCBottom >> #mWithSuper.	
	self deny: (instrumenter isClassReachableInHierarchy: method methodClass).
	
	method := ROCTop >> #mWithSuper.
	self assert: (instrumenter isClassReachableInHierarchy: method methodClass).
	

	
]

{ #category : #tests }
ROCProxyInstrumenterTest >> testNewLinkForSelector [
	|link interceptor|
	link := instrumenter newLinkForSelector: #selector.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #execute.
	self assertEmpty: link arguments.
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector.
	self assert: interceptor metaObject equals: instrumenter metaObject.

	
	link := instrumenter newLinkForSelector: #selector:.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #executeWithArgs:.
	self assert: link arguments equals: #(arguments).
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector:.
	self assert: interceptor metaObject equals: instrumenter metaObject

	
]

{ #category : #tests }
ROCProxyInstrumenterTest >> testOriginalClass [

	instrumenter beForObject: testObject.
	self assert: instrumenter originalClass identicalTo: Object
]

{ #category : #'tests - instrumentation' }
ROCProxyInstrumenterTest >> testRedirectSuperSendsInToSelector [
	|ast superSendNode result|

	testObject := ROCBottom new.
	instrumenter beForObject: testObject.
	testObject class compile: (ROCBottom>>#mWithSuper) sourceCode.
	testObject class compile: 'testSelector x := 42. ^x'.
	ast := (testObject class>>#mWithSuper) ast.
	superSendNode := (ast sendNodes select: [ :node | node receiver isSuperVariable ]) first.
		
	instrumenter redirectSuperSendsIn: ast toSelector: #testSelector.
	
	self assert: superSendNode links notEmpty.
	
	result := testObject mWithSuper.	
	self assert: result equals: 43.
	self assert: testObject x equals: 42
]
