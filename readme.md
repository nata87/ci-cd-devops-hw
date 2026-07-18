# Домашнє завдання 10: Створення гнучкого Terraform-модуля для баз даних

Цей проект містить Terraform-модуль для розгортання баз даних в AWS. Модуль підтримує як класичний Amazon RDS (PostgreSQL), так і масштабований кластер Amazon Aurora.

## Вимоги до домашнього завдання
У межах виконання завдання було реалізовано:

[x] Універсальний модуль: Створено модуль modules/rds, який дозволяє керувати різними типами БД.

[x] Гнучкість (Conditional Logic): Використано параметр use_aurora (тип bool) для перемикання між RDS та Aurora за допомогою мета-аргументу count.

[x] Налаштування мережі: Створено aws_db_subnet_group та aws_security_group з підтримкою вхідних/вихідних правил.

[x] Параметризація: Реалізовано гнучке налаштування параметрів бази даних через dynamic "parameter" блоки.

[x] Best Practices: Розділено ресурси на логічні файли (shared.tf, rds.tf, aurora.tf, variables.tf, outputs.tf).

[x] Масштабованість: Налаштовано підтримку реплік (read-only) для кластера Aurora.


##  Структура модуля
modules/rds/
├── aurora.tf      # Логіка створення Aurora кластера
├── rds.tf         # Логіка створення звичайного RDS інстансу
├── shared.tf      # Спільні ресурси (Subnet Group, Security Group)
├── variables.tf   # Оголошення всіх вхідних змінних
└── outputs.tf     # Виводи для отримання endpoint бази


##  Команди для роботи
Ініціалізація: terraform init

Перевірка плану: terraform plan

Застосування: terraform apply


### Результат

![успішний результат виконання команди terraform apply](images/terraformApply.png)

![AWS Console -> RDS -> Databases](images/database.png)


