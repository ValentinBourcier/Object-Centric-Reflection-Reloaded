Class {
	#name : #ROCPackage,
	#superclass : #ROCBoxs,
	#instVars : [
		'packageWeight',
		'totalWeight',
		'packageContent',
		'packagePrice',
		'packageTax',
		'counter'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #accessing }
ROCPackage >> calculatePackageTax [
	
	packageTax :=  packagePrice * 0.17.
	packagePrice := packagePrice +  packageTax.
]

{ #category : #accessing }
ROCPackage >> clearPackage [
	self packagePrice: 0.
	self clearTaxes.
]

{ #category : #accessing }
ROCPackage >> clearTaxes [

	packageTax := 0.
]

{ #category : #accessing }
ROCPackage >> counter [

	^ counter
]

{ #category : #accessing }
ROCPackage >> counter: anObject [

	counter := anObject
]

{ #category : #accessing }
ROCPackage >> m1 [

	^ 1
]

{ #category : #accessing }
ROCPackage >> m2 [

	self m1.
	self m3.
	self m1.
]

{ #category : #accessing }
ROCPackage >> m3 [

	self m1.

]

{ #category : #accessing }
ROCPackage >> packageContent [

	^ packageContent
]

{ #category : #accessing }
ROCPackage >> packageContent: anObject [

	packageContent := anObject
]

{ #category : #accessing }
ROCPackage >> packagePrice [

	^ packagePrice
]

{ #category : #accessing }
ROCPackage >> packagePrice: anObject [

	packagePrice := anObject
]

{ #category : #accessing }
ROCPackage >> packageTax [

	^ packageTax
]

{ #category : #accessing }
ROCPackage >> packageTax: anObject [

	packageTax := anObject
]

{ #category : #accessing }
ROCPackage >> packageWeight [

	^ packageWeight
]

{ #category : #accessing }
ROCPackage >> packageWeight: anObject [

	packageWeight := anObject
]

{ #category : #accessing }
ROCPackage >> setPackagePrice: aPrice andTax: aTax [

	packagePrice := aPrice.
	packageTax := aTax.
]

{ #category : #'api - accessing' }
ROCPackage >> weight [
	totalWeight := super weight + self packageWeight.
]
