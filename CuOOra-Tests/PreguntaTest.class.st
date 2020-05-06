"
A PreguntaTest is a test class for testing the behavior of Pregunta
"
Class {
	#name : #PreguntaTest,
	#superclass : #TestCase,
	#instVars : [
		'pregunta',
		'topico'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
PreguntaTest >> setUp [
	| t t1 preg u|
	u:= Usuario newNombreUsuario: 'user' contrasenia:'123'.
	t := OrderedCollection new.
	t1 := Topico newTopico: 'Pharo' descripcion: 'Preguntas sobre Pharo'.
	t add: t1.
	t1 := Topico
		newTopico: 'Objetos'
		descripcion: 'Preguntas sobre Objetos'.
	t add: t1.
	topico := t1.
	preg := Pregunta
		newPregunta: 'Iceberg?'
		descripcion: 'No funciona.'
		topicos: t
		usuario: u.
	pregunta := preg
	"-----------------------------"
]

{ #category : #test }
PreguntaTest >> testAgregarRespuesta [
	| r u |
	u := Usuario newNombreUsuario: 'user' contrasenia: '123'.
	r := Respuesta newRespuesta: 'La solucion es...' usuario: u.
	pregunta agregarRespuesta: r.
	pregunta agregarRespuesta: r.
	self assert: (pregunta respuestas includes: r).
]

{ #category : #test }
PreguntaTest >> testObtenerRespuestasPorPuntaje [
	| r1 r2 u1 u2 ord |
	r1 := Respuesta new.
	r2 := Respuesta new.
	u1 := Usuario new.
	u2 := Usuario new.
	r1 darLike: u1.
	r1 darLike: u2.
	r2 darDislike: u1.
	pregunta agregarRespuesta: r1.
	pregunta agregarRespuesta: r2.
	ord := pregunta obtenerRespuestasPorPuntaje.
	self assert: (ord at: 1) equals: r1.
	self assert: (ord at: 2) equals: r2
]

{ #category : #test }
PreguntaTest >> testPerteneceATopico [	
	self assert: (pregunta perteneceATopico: topico)
]
