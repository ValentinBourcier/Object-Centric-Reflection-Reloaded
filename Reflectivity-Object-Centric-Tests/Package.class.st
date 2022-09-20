Class {
	#name : #Package,
	#superclass : #Box,
	#instVars : [
		'packageWeight',
		'totalWeight',
		'packageContent',
		'packagePrice',
		'packageTax',
		'counter'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #accessing }
Package >> calculatePackageTax [
	
	packageTax :=  packagePrice * 0.17.
	packagePrice := packagePrice +  packageTax.
]

{ #category : #accessing }
Package >> clearPackage [

	self packagePrice: 0.
	self clearTaxes.
]

{ #category : #accessing }
Package >> clearTaxes [

	packageTax := 0.
]

{ #category : #accessing }
Package >> counter [

	^ counter
]

{ #category : #accessing }
Package >> counter: anObject [

	counter := anObject
]

{ #category : #accessing }
Package >> packageContent [

	^ packageContent
]

{ #category : #accessing }
Package >> packageContent: anObject [

	packageContent := anObject
]

{ #category : #accessing }
Package >> packagePrice [

	^ packagePrice
]

{ #category : #accessing }
Package >> packagePrice: anObject [

	packagePrice := anObject
]

{ #category : #accessing }
Package >> packageTax [

	^ packageTax
]

{ #category : #accessing }
Package >> packageTax: anObject [

	packageTax := anObject
]

{ #category : #accessing }
Package >> packageWeight [

	^ packageWeight
]

{ #category : #accessing }
Package >> packageWeight: anObject [

	packageWeight := anObject
]

{ #category : #'api - accessing' }
Package >> weight [
	totalWeight := super weight + self packageWeight.
]
