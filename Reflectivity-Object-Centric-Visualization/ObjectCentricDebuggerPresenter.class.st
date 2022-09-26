Class {
	#name : #ObjectCentricDebuggerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'dynamicPage',
		'content',
		'InstalledTab',
		'addOCDTab',
		'mainNotebook',
		'installedOCDTable',
		'counterOCDsLabel',
		'removeObjectButton',
		'objectPointsCodePresenter'
	],
	#category : #'Reflectivity-Object-Centric-Visualization'
}

{ #category : #specs }
ObjectCentricDebuggerPresenter class >> initialExtent [

	^ 600 @ 500
]

{ #category : #layout }
ObjectCentricDebuggerPresenter class >> open [

	<script>
	self new open.
]

{ #category : #specs }
ObjectCentricDebuggerPresenter class >> title [

	^ 'OCD Extension'
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> addOCDPage [

	^ SpNotebookPage
		  title: 'Add OCD'
		  icon: (self iconNamed: #nautilusIcon)
		  provider: [ 
			  SpClassMethodBrowser new
				  classes: self class environment allClasses;
				  yourself ]
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> connectPresenters [
]

{ #category : #layout }
ObjectCentricDebuggerPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: mainNotebook;
		add: (SpBoxLayout newLeftToRight
			add: counterOCDsLabel;
			add: removeObjectButton expand: false)
		expand: false;
		add: objectPointsCodePresenter;
		 yourself
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializeCounterOCDsLabel [

	counterOCDsLabel := self newLabel.
	counterOCDsLabel label: '1 object'
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializeInstalledOCDTable [

	installedOCDTable := self newTable.
	installedOCDTable
		addColumn: (SpIndexTableColumn new
				 title: 'Index';
				 beNotExpandable;
				 yourself);
		addColumn: (SpStringTableColumn
				 title: 'Object / Instance of an object'
				 evaluated: [ :each | each asString ]);
		addColumn: (SpStringTableColumn
				 title: 'Variable / Method name'
				 evaluated: [ :each | each variableName ]);
		addColumn: (SpStringTableColumn
				 title: 'Control'
				 evaluated: [ :each | each control ])
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializeMainNotebook [

	"
	mainNotebook := self newNotebook.
	mainNotebook
		addPage: self installedPage;
		addPage: self addOCDPage."

	mainNotebook := self newNotebook.
	mainNotebook addPageTitle: 'Installed' provider: installedOCDTable
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializeObjectPointsCodePresenter [

	objectPointsCodePresenter := self newCode
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializePresenters [

	self initializeInstalledOCDTable.
	self initializeCounterOCDsLabel.
	self initializeRemoveObjectButton.
	self initializeObjectPointsCodePresenter.
	self initializeMainNotebook
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializeRemoveObjectButton [

	removeObjectButton := self newButton.
	removeObjectButton label: 'Remove'
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self class title;
		initialExtent: self class initialExtent
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> installedPage [

	^ (SpNotebookPage title: 'Installed' provider: [ 
		   SpDemoMessageBrowser new
			   messages: Object methods;
			   yourself ]) yourself
]
