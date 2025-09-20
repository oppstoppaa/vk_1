import mysql.connector
import random
import string
import time
from mysql.connector import Error


DB_HOST = "37.139.41.191"
DB_USER = "yakovtseva_db"
DB_PASSWORD = ".091s9T8cZtn920UG"  
DB_NAME = "YAKOVTSEVA_database"


NUM_TABLES = 200
NUM_COLUMNS = 50
ROWS_PER_TABLE = 10  


def random_string(min_len=4, max_len=8):
    length = random.randint(min_len, max_len)
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))


def main():
    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        cursor = conn.cursor()
        print(f"Подключение к базе данных {DB_NAME} установлено.")

        for t in range(1, NUM_TABLES + 1):
            table_name = f"table_{t}"

            # Создание таблицы
            columns_def = ", ".join([f"col_{c} VARCHAR(8)" for c in range(1, NUM_COLUMNS + 1)])
            create_sql = f"""
                CREATE TABLE IF NOT EXISTS {table_name} (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    {columns_def}
                )
            """
            cursor.execute(create_sql)
            print(f"Создана таблица {table_name}")

            # Подготовка SQL-запроса на вставку
            column_names = ", ".join([f"col_{c}" for c in range(1, NUM_COLUMNS + 1)])
            placeholders = ", ".join(["%s"] * NUM_COLUMNS)
            insert_sql = f"INSERT INTO {table_name} ({column_names}) VALUES ({placeholders})"

            # Вставка строк
            for r in range(ROWS_PER_TABLE):
                data = [random_string() for _ in range(NUM_COLUMNS)]
                cursor.execute(insert_sql, data)

            conn.commit()
            print(f" Заполнена таблица {table_name} ({ROWS_PER_TABLE} строк)")

        print("\n Все таблицы успешно созданы и заполнены!")
        
    except Error as e:
        print(f"Ошибка при подключении или работе с БД: {e}")

    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("Соединение с базой данных закрыто.")

# --- Запуск ---
if __name__ == "__main__":
    start_time = time.time()
    main()
    elapsed = time.time() - start_time
    print(f"\n Время выполнения: {elapsed:.2f} сек")
