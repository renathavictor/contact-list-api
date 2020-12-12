# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

user = User.create([
  {
    "name": "Fulano de Tal",
    "email": "fulano@email.com",
    "password": "123456",
    "password_confirmation": "123456"
  },
  {
    "name": "Usuário da Silva",
    "email": "usuario@email.com",
    "password": "123456",
    "password_confirmation": "123456"
  }
])

list = List.create([
  {
    "title": "Work Friends",
    "created_by": User.first.id
  }
])
