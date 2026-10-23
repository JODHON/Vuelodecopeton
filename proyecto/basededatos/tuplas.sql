-- Para la tabla Asesoria
-- 1. Si está finalizada/cancelada pero la fecha es nula, le ponemos la fecha de hoy.
UPDATE Asesorias 
SET FechaFinalizacion = SYSDATE 
WHERE Estado IN ('Finalizada', 'Cancelada') AND FechaFinalizacion IS NULL;

-- 2. Si está 'En curso' pero tiene una fecha, se la quitamos.
UPDATE Asesorias 
SET FechaFinalizacion = NULL 
WHERE Estado = 'En curso' AND FechaFinalizacion IS NOT NULL;

-- Para la tabla ProyectosInvestigacion
-- 1. Si está finalizado/cancelado pero la fecha es nula, le ponemos la fecha de hoy.
UPDATE ProyectosInvestigacion 
SET FechaFinalizacion = SYSDATE 
WHERE Estado IN ('Finalizado', 'Cancelada') AND FechaFinalizacion IS NULL;

-- 2. Si está 'En curso' pero tiene una fecha, se la quitamos.
UPDATE ProyectosInvestigacion 
SET FechaFinalizacion = NULL 
WHERE Estado = 'En curso' AND FechaFinalizacion IS NOT NULL;

COMMIT;
-- RESTRICCIÓN 1: XOR - Pago debe tener OR Tour OR Asesoria pero no ambos
ALTER TABLE Pagos
ADD CONSTRAINT rst_pago_xor_tour_asesoria
CHECK (
 (IdTour IS NOT NULL AND IdAsesoria IS NULL) OR
 (IdTour IS NULL AND IdAsesoria IS NOT NULL)
);
 
-- RESTRICCIÓN 2: Fecha de finalización > Fecha de inicio en ASESORIA
ALTER TABLE Asesorias
ADD CONSTRAINT rst_asesoria_fechas
CHECK (FechaFinalizacion IS NULL OR FechaFinalizacion > FechaInicio);
 
-- RESTRICCIÓN 3: Fecha de finalización > Fecha de inicio en PROYECTOS
ALTER TABLE ProyectosInvestigacion
ADD CONSTRAINT rst_proyecto_fechas
CHECK (FechaFinalizacion IS NULL OR FechaFinalizacion > FechaInicio);
 
-- RESTRICCIÓN 4: Estado consistente en RESERVA
ALTER TABLE Reservas
ADD CONSTRAINT rst_reserva_estado_valido
CHECK (Estado IN ('Pendiente', 'Confirmada', 'Cancelada'));
 
-- RESTRICCIÓN 5: Cantidad y Monto positivos en Pago.
ALTER TABLE Pagos
ADD CONSTRAINT rst_pago_monto_estado
CHECK (Monto > 0);
 
-- RESTRICCIÓN 7: Asesoria debe tener estado consistente
ALTER TABLE Asesorias
ADD CONSTRAINT rst_asesoria_estado_consistente
CHECK (
 Estado IN ('En curso', 'Finalizada', 'Cancelada') AND
 (
   (Estado = 'En curso' AND FechaFinalizacion IS NULL) OR
   (Estado IN ('Finalizada', 'Cancelada') AND FechaFinalizacion IS NOT NULL)
 )
);
 
-- RESTRICCIÓN 8: Proyecto debe tener estado y fechas consistentes
ALTER TABLE ProyectosInvestigacion
ADD CONSTRAINT rst_proyecto_estado_consistente
CHECK (
 Estado IN ('En curso', 'Finalizado', 'Cancelado') AND
 (
   (Estado = 'En curso' AND FechaFinalizacion IS NULL) OR
   (Estado IN ('Finalizado', 'Cancelada') AND FechaFinalizacion IS NOT NULL)
 )
);
 
-- RESTRICCIÓN 9: Avistamiento debe tener cantidad positiva
ALTER TABLE Avistamientos
ADD CONSTRAINT rst_avistamiento_datos_validos
CHECK (Cantidad > 0);
 
