#!/bin/bash

# Запрашиваем имя пользователя
read -p "Введите имя пользователя: " username

# Проверяем, существует ли пользователь
if id "$username" >/dev/null 2>&1; then
    echo "Пользователь $username уже существует"
    exit 1
fi

# Запрашиваем пароль
read -s -p "Введите пароль: " password
echo

# Запрашиваем подтверждение пароля
read -s -p "Подтвердите пароль: " password_confirm
echo

# Проверяем, что пароль и подтверждение совпадают
if [ "$password" != "$password_confirm" ]; then
    echo "Пароли не совпадают"
    exit 1
fi

# Добавляем пользователя в систему с созданием домашнего каталога
useradd -m "$username" -s /bin/bash

# Устанавливаем пароль для пользователя
echo "$username:$password" | chpasswd

# Настраиваем окружение пользователя
echo "export LANG=en_US.UTF-8" >> /home/$username/.bashrc
echo "export LC_ALL=en_US.UTF-8" >> /home/$username/.bashrc

# Сообщаем об успешном выполнении задачи
echo "Пользователь $username успешно добавлен в систему"
exit 0