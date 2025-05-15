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
      puts "1. Переглянути всі контакти"
      puts "2. Додати контакт"
      puts "3. Редагувати контакт"
      puts "4. Видалити контакт"
      puts "5. Пошук контакту"
      puts "6. Зберегти у JSON"
      puts "7. Зберегти у YAML"
      puts "8. Завантажити з JSON"
      puts "9. Завантажити з YAML"
      puts "0. Вийти"
      print "Ваш вибір: "
      case gets.to_i
      when 1 then list_contacts
      when 2 then add_contact
      when 3 then edit_contact
      when 4 then delete_contact
      when 5 then search_contact
      when 6 then save_to_json
      when 7 then save_to_yaml
      when 8 then load_from_json
      when 9 then load_from_yaml
      when 0 then break
      else puts "Невірний вибір."
      end
    end
  end

  def list_contacts
    if @contacts.empty?
      puts "Контакти відсутні."
    else
      puts "\nСписок контактів:"
      @contacts.each_with_index do |(name, phones), index|
        puts "#{index + 1}. #{name}: #{phones.join(', ')}"
      end
    end
  end

  def add_contact
    print "Введіть ім'я нового контакту: "
    name = gets.strip
    if @contacts.key?(name)
      puts "Контакт вже існує. Додайте або відредагуйте його."
    else
      print "Введіть номери телефону через кому: "
      phones = gets.strip.split(',').map(&:strip)
      @contacts[name] = phones
      puts "Контакт додано."
    end
  end

  def edit_contact
    print "Введіть ім'я контакту для редагування: "
    name = gets.strip
    if @contacts.key?(name)
      puts "Поточні номери: #{@contacts[name].join(', ')}"
      print "Введіть нові номери телефону через кому: "
      phones = gets.strip.split(',').map(&:strip)
      @contacts[name] = phones
      puts "Контакт оновлено."
    else
      puts "Контакт не знайдено."
    end
  end

  def delete_contact
    print "Введіть ім'я контакту для видалення: "
    name = gets.strip
    if @contacts.delete(name)
      puts "Контакт видалено."
    else
      puts "Контакт не знайдено."
    end
  end

  def search_contact
    print "Введіть ім'я або частину імені для пошуку: "
    query = gets.strip.downcase
    results = @contacts.select { |name, _| name.downcase.include?(query) }
    if results.empty?
      puts "Контакти не знайдені."
    else
      puts "Знайдені контакти:"
      results.each_with_index do |(name, phones), index|
        puts "#{index + 1}. #{name}: #{phones.join(', ')}"
      end
    end
  end

  def save_to_json
    File.write(FILE_JSON, JSON.pretty_generate(@contacts))
    puts "Контакти збережено у JSON."
  end

  def save_to_yaml
    File.write(FILE_YAML, @contacts.to_yaml)
    puts "Контакти збережено у YAML."
  end

  def load_from_json
    if File.exist?(FILE_JSON)
      @contacts = JSON.parse(File.read(FILE_JSON))
      puts "Контакти завантажено з JSON."
    else
      puts "Файл JSON не знайдено."
    end
  end

  def load_from_yaml
    if File.exist?(FILE_YAML)
      @contacts = YAML.load_file(FILE_YAML)
      puts "Контакти завантажено з YAML."
    else
      puts "Файл YAML не знайдено."
    end
  end
end

Phonebook.new.run
