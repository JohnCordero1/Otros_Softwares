/*-----------------------------------------------------------------------------
              SIMULACIÓN DE LA LEY DE LOS GRANDES NÚMEROS
Nombre: John Cordero
-----------------------------------------------------------------------------*/

clear all
set obs 1000

//Paso 1: Generar números aleatorios
set seed 12345 //Fijamos una semilla para la reproducibilidad

* Generar una variable con datos aleatorios distribuidos uniformemente
gen random_data = uniform()
histogram random_data
mean random_data //mean = .4925308
local media_poblacional = r(mean)

//Paso 2: Comprobar que la media muestral converge a la esperanza poblacional
gen sample_means = .
gen sample_sizes = .
local total_samples = 1000 //N° total de muestas a generar

quietly forval i = 1/`total_samples'{
	* Generar una muestra aleatoria de tamaño i
	preserve
	sample `i', count
	
	* Calcular la media de la muestra
	summarize random_data
	global sample_means = r(mean)
	global sample_sizes = `i'
	restore
	
	replace sample_means = $sample_means in $sample_sizes
	replace sample_sizes = `i' in $sample_sizes

}

//Paso 3: Graficar la convergencia
twoway (line sample_means sample_sizes, yline($media_poblacional)), ///
	ytitle("Medias muestrales") xtitle("Tamaño de la muestra") ///
	title("Ley de los grandes Números")
graph export "Gráfico del la Ley de los Grandes Números.pdf", replace
