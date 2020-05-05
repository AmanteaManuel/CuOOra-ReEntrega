"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCuOOra,
	#superclass : #PackageManifest,
	#category : #'CuOOra-Manifest'
}

{ #category : #'code-critics' }
ManifestCuOOra class >> ruleRBSelfSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#Respuesta)) #'2020-03-29T15:34:25.919691-03:00') )
]

{ #category : #'code-critics' }
ManifestCuOOra class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#HomeComponent #renderContentOn: #false)) #'2020-04-13T17:56:51.725326-03:00') )
]
