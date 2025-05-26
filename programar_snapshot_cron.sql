
-- Crear extensión pg_cron si no existe
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Programar tarea diaria para snapshot de ítems a las 23:59
SELECT cron.schedule(
  'snapshot_diario',
  '59 23 * * *',
  $$ CALL snapshot_item_state(CURRENT_DATE); $$
);

-- Ver tareas registradas (opcional)
-- SELECT * FROM cron.job;
