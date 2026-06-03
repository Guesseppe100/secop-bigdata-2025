\# SECOP Big Data 2025



\## Descripción del proyecto



Este proyecto implementa una arquitectura de datos por lotes para analizar información pública de contratación estatal del SECOP correspondiente al año 2025.



El enfoque del proyecto está diseñado para trabajar con grandes volúmenes de datos de manera progresiva. Primero se inicia con lotes pequeños para validar la lógica del proceso y posteriormente se escala el volumen de ingesta, limpieza, integración y análisis.



El proyecto utiliza GitHub para control de versiones, Spark para procesamiento distribuido y Databricks Free Edition como entorno de ejecución.



\---



\## Objetivo general



Construir una canalización de datos escalable, reutilizable y documentada para obtener, procesar, integrar y analizar información de contratación pública del SECOP durante el año 2025.



\---



\## Objetivos específicos



\- Diseñar una arquitectura de datos por capas.

\- Iniciar la ingesta con lotes pequeños de información.

\- Generalizar el código para integrar múltiples fuentes de datos.

\- Aplicar filtros para trabajar únicamente con registros del año 2025.

\- Usar Spark como motor principal de procesamiento.

\- Integrar el proyecto con GitHub y Databricks.

\- Preparar la información para análisis, visualización y posibles integraciones con MongoDB.



\---



\## Arquitectura del proyecto



El proyecto se organiza bajo una arquitectura tipo Lakehouse, dividida en las siguientes capas:



\### Layer 0 - Datos crudos



Zona inicial de aterrizaje de datos. En esta capa se almacenan los datos obtenidos directamente desde las fuentes originales, sin transformaciones profundas.



\### Bronze - Datos crudos estructurados



En esta capa los datos provenientes de Layer 0 se convierten en tablas estructuradas, conservando la mayor fidelidad posible frente a la fuente original.



\### Silver - Datos limpios y estandarizados



En esta capa se aplican procesos de limpieza, normalización, conversión de tipos de datos, eliminación de duplicados y validaciones básicas de calidad.



\### Gold - Datos analíticos



En esta capa se generan tablas consolidadas y listas para análisis, reportes, visualización o integración con otras herramientas.



\---



\## Fuentes principales



Las fuentes principales consideradas para el proyecto son:



\- Contratos SECOP II.

\- Adiciones o modificaciones contractuales.

\- Información de ejecución contractual.

\- DIVIPOLA para normalización territorial.

\- Fuentes complementarias para análisis contextual, si son requeridas.



\---



\## Ventana de análisis



El análisis se limita únicamente al año 2025.



```text

Desde: 2025-01-01

Hasta: 2025-12-31

