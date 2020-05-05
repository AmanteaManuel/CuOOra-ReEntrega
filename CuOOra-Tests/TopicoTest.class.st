"
A TopicoTest is a test class for testing the behavior of Topico
"
Class {
	#name : #TopicoTest,
	#superclass : #TestCase,
	#instVars : [
		'topico'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
TopicoTest >> setUp [
	topico := Topico newTopico: 'POO' descripcion: 'Consultas' 

	
]

{ #category : #test }
TopicoTest >> testExisteNombre [

	self assert: (topico existeNombre: 'POO').
]
