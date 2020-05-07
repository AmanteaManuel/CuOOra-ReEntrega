"
A PostTest is a test class for testing the behavior of Post
"
Class {
	#name : #PostTest,
	#superclass : #TestCase,
	#instVars : [
		'pregunta',
		'usuario'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
PostTest >> setUp [
	| topicos u|
	u:= Usuario newNombreUsuario: 'user' contrasenia:'123'.
	usuario := Usuario newNombreUsuario: 'Manuel' contrasenia: 'Amantea'.
	topicos := OrderedCollection new.
	topicos add: [ Topico newTopico: 'SQL' descripcion: 'base de datos' ].
	pregunta := Pregunta
		newPregunta: 'pregunta prueba'
		descripcion: 'asd'
		topicos: topicos
		usuario:u.
]

{ #category : #test }
PostTest >> testDiferenciaLikesDislikes [
	| u1 u2 u3 |
	u1 := Usuario new.
	u2 := Usuario new.
	u3 := Usuario new.
	u1 darLike: pregunta.
	u2 darLike: pregunta.
	u3 darDislike: pregunta.
	self assert: pregunta diferenciaLikesDislikes equals: 1
]

{ #category : #test }
PostTest >> testTieneDislikeDe [
	| u |
	u := Usuario newNombreUsuario: 'Juan' contrasenia: 'Amantea'.	
	pregunta darDislike:u.	
	self assert: [ pregunta tieneDislikeDe: u ]
]

{ #category : #test }
PostTest >> testTieneLikeDe [
	| u |
	u := Usuario newNombreUsuario: 'Juan' contrasenia: 'Amantea'.
	pregunta darLike: u.
	self assert: [ pregunta tieneLikeDe: u ]
]
