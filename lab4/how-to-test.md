Run: `rails console`

## Невалідний контакт без імені
* `c = Contact.new`
* `c.valid?`               # => false
* `c.errors.full_messages` # => ["Name can't be blank"]

## Валідний контакт
* `c = Contact.create(name: "Олена")`

## Невалідний номер
* `c.phone_numbers.create(number: "abc123")` # => false, помилка формату

## Валідний номер
* `c.phone_numbers.create(number: "+380991112233")`

##
## Переглянути записи в базі даних:
```ruby
Contact.all
PhoneNumber.all
Contact.first.phone_numbers
```