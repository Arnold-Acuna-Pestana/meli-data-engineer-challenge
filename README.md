# 🛒 Mercado Libre - Data Engineer Challenge

Este repositorio contiene la solución al challenge técnico para la posición de **Data Engineer** en Mercado Libre. Se abordan los aspectos de modelado de datos, carga de información, consultas de negocio y automatización con cron.

---

## 📁 Estructura del proyecto

```
meli-data-engineer-challenge/
├── create_tables.sql               # DDL para crear las tablas en PostgreSQL
├── cargar_csv_postgres.py          # Script Python para cargar CSVs a PostgreSQL
├── programar_snapshot_cron.sql     # Crea un job con pg_cron para snapshot diario
├── docker-compose.yml              # Configura PostgreSQL + pgAdmin + pg_cron
├── Dockerfile                      # Imagen personalizada con pg_cron compilado
├── init_pgcron.sql                 # Habilita la extensión pg_cron
├── requirements.txt                # Dependencias Python
├── .env.example                    # Variables de entorno
├── respuestas_negocio.sql          # Consultas para resolver las consignas
├── mock_data/                      # CSVs generados con datos simulados
├── notebooks/
│   └── pyspark_challenge_notebook.ipynb
└── diagramas/
    └── DER_MercadoLibre_Modelo.png
```

---

## ⚙️ Requisitos

- Docker + Docker Compose
- Python 3.9+
- pip

---

## 🚀 Cómo ejecutar el proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu_usuario/meli-data-engineer-challenge.git
cd meli-data-engineer-challenge
```

### 2. Configurar variables de entorno

```bash
cp .env.example .env
```

### 3. Levantar la base de datos y pgAdmin

```bash
docker compose up -d --build
```

pgAdmin estará disponible en [http://localhost:8080](http://localhost:8080)

- Email: `admin@example.com`
- Password: `admin`

---

### 4. Crear las tablas

```bash
psql -U postgres -d meli_challenge -f create_tables.sql
```

---

### 5. Cargar los datos desde los CSV

```bash
pip install -r requirements.txt
python cargar_csv_postgres.py
```

---

### 6. Programar snapshot diario con pg_cron

```bash
psql -U postgres -d meli_challenge -f programar_snapshot_cron.sql
```

---

### 7. Ejecutar consultas de negocio

```bash
psql -U postgres -d meli_challenge -f respuestas_negocio.sql
```

---

## 🧠 Consultas incluidas

- Clientes que cumplen años hoy y vendieron más de $1500 en enero 2020
- Top 5 vendedores mensuales en categoría "Celulares"
- Registro diario en `item_history` (automatizado con `pg_cron`)

---

## 📊 Análisis en Spark (opcional)

En `notebooks/pyspark_challenge_notebook.ipynb` se muestra cómo resolver las consultas usando Spark SQL.

Podés ejecutarlo directamente en [Google Colab](https://colab.research.google.com/) cargando tus archivos CSV.

---

## 🧾 Licencia

Este proyecto fue desarrollado como parte de un ejercicio técnico. Podés usarlo como referencia educativa.