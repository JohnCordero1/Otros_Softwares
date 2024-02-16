/*-----------------------------------------------------------------------------
              SIMULACIÓN DEL TEOREMA DEL LIMITE CENTRAL
Nombre: John Cordero
-----------------------------------------------------------------------------*/
clear all
set obs 10000

//Paso 1: Generar números aleatorios
set seed 12345 //Fijamos una semilla para la reproducibilidad

* Generar una muestra de una distribución exponencial
gen muestra = rweibull(2,1)
summarize muestra

* Número de muestras a tomar
local n_muestras 10000

* Tamaño de cada muestra
local tamano_muestra 10

* Almacenar medias de muestras
gen medias_muestras = .

//Paso 2: Realizar muestras y calcular las medias
quietly forval i = 1/`n_muestras'{

	preserve
	
	* Tomar una muestra aleatoria
	sample `tamano_muestra'
	
	* Calcular la media de las muestras y la almacenamos
	summarize muestra
	global medias_muestras=r(mean)
	
	restore
	
	replace medias_muestras = $medias_muestras in `i'
}

//Paso 3: Graficamos las medias muestrales
histogram medias_muestras, normal
