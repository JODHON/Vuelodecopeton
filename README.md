

# 🐦 Copetón — Ecoturismo e Investigación Ambiental

![Logo Copetón](copeton.png)

**Copetón** es una plataforma orientada a la gestión de ecoturismo, registro de avistamientos de fauna y desarrollo de proyectos de investigación ambiental.

---

## 🚀 Funcionalidades Principales

* **Gestión de Usuarios:** Perfiles para visitantes, académicos, administradores y entidades públicas/privadas[cite: 1].
* **Avistamientos:** Registro de observaciones de especies con ubicación geográfica, fechas y evidencia fotográfica[cite: 1].
* **Tours y Reservas:** Programación de recorridos guiados, gestión de cupos y reservas[cite: 1].
* **Investigación:** Seguimiento a proyectos científicos, asesorías y generación de reportes[cite: 1].
* **Pagos:** Control de transacciones asociadas a reservas y servicios[cite: 1].

---

## 📊 Modelo Lógico (Entidades)

* **Usuarios y Roles:** `Usuarios`, `PersonasComunes`, `PersonasAcademicas`, `Administradores`, `EntidadesEducativas`, `EntidadesCorporativas`[cite: 1].
* **Especies y Registros:** `Especies`, `Avistamientos`, `Ubicaciones`, `Avistamientos_Ubicaciones`, `Observaciones`[cite: 1].
* **Ecoturismo:** `Tours`, `Tours_Ubicaciones`, `Reservas`[cite: 1].
* **Investigación:** `ProyectosInvestigacion`, `Asesorias`, `Reportes`, `ProyectosInvestigacion_Reportes`[cite: 1].
* **Finanzas:** `Pagos`[cite: 1].
