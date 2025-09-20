##  Описание
Этот проект автоматизирует:
- Развертывание облачной инфраструктуры с помощью **Terraform**.
- Подключение к **MySQL** и создание множества таблиц.
- Наполнение базы случайными тестовыми данными для нагрузочного тестирования.


##  Структура проекта

├── init_db.py # Скрипт для инициализации базы
├── output.tf # Terraform outputs
├── vkcs_provider.tf # Terraform провайдер для VK Cloud
├── terraform.tfstate # Состояние Terraform
├── LICENSE.txt # MPL 2.0 License

##  Установка и запуск

### 1. Установка зависимостей
```bash
pip install mysql-connector-python
```

### 2. Инициализация Terraform
```bash
terraform init
terraform apply
```
### 3. Настройка базы данных

Укажи параметры подключения в init_db.py:
```bash
DB_HOST = "your-db-host"
DB_USER = "your-user"
DB_PASSWORD = "your-password"
DB_NAME = "your-database"
```
### 4. Запуск скрипта
```bash
python init_db.py
```
##  Скриншот работы
<img src="C:\Users\oppstoppa\Documents\Screen.jpg">
```
