"
An UsuarioTest is a test class for testing the behavior of Usuario
"
Class {
	#name : #UsuarioTest,
	#superclass : #TestCase,
	#instVars : [
		'usuario',
		'top'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
UsuarioTest >> setUp [
	| topicos t p r u1 u2 u3 u4 |
	t := Topico newTopico: 'SQL' descripcion: 'topico sql'.
	topicos := OrderedCollection new.
	topicos add: t.
	u1 := Usuario newNombreUsuario: 'user' contrasenia: '123'.
	u2 := Usuario newNombreUsuario: 'user2' contrasenia: '123'.
	u3 := Usuario newNombreUsuario: 'user3' contrasenia: '123'.
	"u4 := Usuario newNombreUsuario: 'user4' contrasenia: '123'."
	u1 agregarTopicoInteres: t.
	top := t.
	"---------------------------------------------------------"
	p := Pregunta
		newPregunta: 'select?'
		descripcion: 'como se hace un select'
		topicos: topicos
		usuario: u1.
	u4 := Usuario newNombreUsuario: 'uu1' contrasenia: '123'.
	r := Respuesta newRespuesta: 'esta mal escrito el metodo' usuario: u4.
	"---------------------------------------------------------"
	p darLike: u2.
	p darDislike: u3.
	r darDislike: u3.
	u1 agregarPregunta: p.
	u1 agregarPregunta: r.
	usuario := u1
]

{ #category : #test }
UsuarioTest >> testAgregarPregunta [
	| u preg |
	u := Usuario newNombreUsuario: 'user' contrasenia: '123'.
	preg := Pregunta
		newPregunta: 'select?'
		descripcion: 'como se hace un select'
		topicos: 'SQL'
		usuario: u.
	usuario agregarPregunta: preg.
	self assert: (usuario posts includes: preg).
]

{ #category : #test }
UsuarioTest >> testAgregarRespuesta [
	| resp u |
	u:= Usuario newNombreUsuario: 'user' contrasenia:'123'.
	resp := Respuesta newRespuesta: 'te falta el ;' usuario: u.
	usuario agregarRespuesta: resp.
	self assert: (usuario posts includes: resp)
]

{ #category : #test }
UsuarioTest >> testAgregarTopicoInteres [
	| topico topicoFail |
	topico := Topico
		newTopico: 'Base de datos'
		descripcion: 'topico Base de datos'.
	topicoFail := top.
	usuario agregarTopicoInteres: topico.
	self assert: (usuario topicosDeInteres select: [ :t | t nombre = 'Base de datos' ] )size equals: 1 .
	usuario agregarTopicoInteres: topicoFail.
	self assert: (usuario topicosDeInteres select: [ :t | t nombre = 'SQL' ] ) size equals: 1.
]

{ #category : #test }
UsuarioTest >> testCalcularPuntaje [
	self assert: 20 + 50 + 0 + -1 equals: usuario calcularPuntaje.
]

{ #category : #test }
UsuarioTest >> testCantidadPreguntas [
	self assert: usuario cantidadPreguntas equals: 1 
]

{ #category : #test }
UsuarioTest >> testCantidadRespuestas [
	self assert:  usuario cantidadRespuestas equals: 1 
]

{ #category : #test }
UsuarioTest >> testDiferenciaLikeDislikesPreguntas [
	self assert: usuario diferenciaLikeDislikesPreguntas equals: 0
]

{ #category : #test }
UsuarioTest >> testDiferenciaLikeDislikesRespuestas [
	self assert: usuario diferenciaLikeDislikesRespuestas equals: -1 
]

{ #category : #test }
UsuarioTest >> testEliminarPregunta [
	| u preguntaBorrar p tamaño |
	u := Usuario newNombreUsuario: 'pruebaBorrado' contrasenia: '123'.
	preguntaBorrar := Pregunta
		newPregunta: 'delete?'
		descripcion: 'como se hace un delete'
		topicos: ''
		usuario: u.
	u agregarPregunta: preguntaBorrar.
	p := u eliminarPregunta: preguntaBorrar.
	self deny: [ u obtenerPreguntas includes: p ].
	
	"borro una pregunta que no existe"
	tamaño := u obtenerPreguntas size.
	u eliminarPregunta: preguntaBorrar.
	self assert: u obtenerPreguntas size equals: tamaño
]

{ #category : #test }
UsuarioTest >> testObtenerPreguntas [
	| list |
	list := usuario obtenerPreguntas.
	self assert:  list size equals: 1 
]

{ #category : #test }
UsuarioTest >> testObtenerRespuestas [
	| list |
	list := usuario obtenerRespuestas.
	self assert:  list size equals: 1 
]

{ #category : #test }
UsuarioTest >> testSeguirUsuario [
	| u1 |
	u1 := Usuario newNombreUsuario: 'Manuel' contrasenia: '123'.
	usuario seguirUsuario: u1.
	usuario seguirUsuario: u1.
	self assert: 1 equals: (usuario follows select: [ :f | f = u1 ]) size
]

{ #category : #test }
UsuarioTest >> testSigueAUsuario [
	|u1 u2|
	u1:= Usuario newNombreUsuario: 'Manuel' contrasenia: '123'.
	u2 := Usuario newNombreUsuario: 'NoSeguir' contrasenia: 'NoSeguir'. 
	usuario seguirUsuario: u1.
	self assert: [usuario sigueAUsuario: u1].
	self deny: [usuario sigueAUsuario: u2].
]
