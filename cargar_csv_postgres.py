import pandas as pd
from sqlalchemy import create_engine

# ⚙️ Configuración de conexión (asegurate que coincide con docker-compose)
db_user = "postgres"
db_password = "postgres"
db_host = "localhost"
db_port = "5432"
db_name = "meli_challenge"

# 🔌 Crear la conexión al motor de PostgreSQL
engine = create_engine(f"postgresql+psycopg2://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}")

# 📥 Leer los archivos CSV (deben estar en la misma carpeta)
df_customers = pd.read_csv("mock_data/customers.csv")
df_items = pd.read_csv("mock_data/items.csv")
df_orders = pd.read_csv("mock_data/orders.csv")
df_categories = pd.read_csv("mock_data/categories.csv")
df_item_history = pd.read_csv("mock_data/item_history.csv")

# 📤 Insertar los datos en PostgreSQL (reemplaza las tablas si ya existen)
df_customers.to_sql("customer", engine, if_exists="append", index=False)
df_categories.to_sql("category", engine, if_exists="append", index=False)
df_items.to_sql("item", engine, if_exists="append", index=False)
df_orders.to_sql("orders", engine, if_exists="append", index=False)
df_item_history.to_sql("item_history", engine, if_exists="append", index=False)

print("✅ Datos cargados correctamente en PostgreSQL.")
