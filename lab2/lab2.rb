require 'yaml'
require 'json'

class Phonebook
  FILE_JSON = 'storage/contacts.json'
  FILE_YAML = 'storage/contacts.yaml'

  def initialize
    @contacts = {}
  end

  def run
    loop do
      puts "\n--- Телефонний довідник ---"
      puts "1. Переглянути контакти"
      puts "2. Додати контакт"
      puts "3. Редагувати контакт"
      puts "4. Видалити контакт"
      puts "5. Зберегти у JSON"
      puts "6. Зберегти у YAML"
      puts "7. Завантажити з JSON"
      puts "8. Завантажити з YAML"
      puts "9. Вийти"
      print "Ваш вибір: "
      case gets.to_i
      when 1 then list_contacts
      when 2 then add_contact
      when 3 then edit_contact
      when 4 then delete_contact
      when 5 then save_to_json
      when 6 then save_to_yaml
      when 7 then load_from_json
      when 8 then load_from_yaml
      when 9 then break
      else puts "Невірний вибір"
      end
    end
  end

  def list_contacts
    if @contacts.empty?
      puts "Контакти відсутні."
    else
      @contacts.each_with_index do |(name, phones), index|
        puts "#{index + 1}. #{name}: #{phones.join(', ')}"
      end
    end
  end

  def add_contact
    print "Введіть ім'я: "
    name = gets.strip
    print "Введіть номери телефону через кому: "
    phones = gets.strip.split(',').map(&:strip)
    @contacts[name] = phones
    puts "Контакт додано."
    list_contacts
  end

  def edit_contact
    list_contacts
    print "Введіть ім'я контакту для редагування: "
    name = gets.strip
    if @contacts[name]
      print "Нові номери телефону через кому: "
      phones = gets.strip.split(',').map(&:strip)
      @contacts[name] = phones
      puts "Контакт оновлено."
      list_contacts
    else
      puts "Контакт не знайдено."
    end
  end

  def delete_contact
    list_contacts
    print "Введіть ім'я контакту для видалення: "
    name = gets.strip
    if @contacts.delete(name)
      puts "Контакт видалено."
      list_contacts
    else
      puts "Контакт не знайдено."
    end
  end

  def save_to_json
    File.write(FILE_JSON, JSON.pretty_generate(@contacts))
    puts "Збережено у JSON."
    list_contacts
  end

  def save_to_yaml
    File.write(FILE_YAML, @contacts.to_yaml)
    puts "Збережено у YAML."
    list_contacts
  end

  def load_from_json
    if File.exist?(FILE_JSON)
      @contacts = JSON.parse(File.read(FILE_JSON))
      puts "Завантажено з JSON."
      list_contacts
    else
      puts "Файл JSON не знайдено."
    end
  end

  def load_from_yaml
    if File.exist?(FILE_YAML)
      @contacts = YAML.load_file(FILE_YAML)
      puts "Завантажено з YAML."
      list_contacts
    else
      puts "Файл YAML не знайдено."
    end
  end
end

Phonebook.new.run