require 'yaml'
require 'json'

class Phonebook
  FILE_JSON = 'storage/contacts.json'
  FILE_YAML = 'storage/contacts.yaml'

  def initialize
    @contacts = {}
  end

  def run
    add_contact("Олег", ["123-456", "789-000"])
    add_contact("Ірина", ["555-555"])
    add_contact("Андрій", ["321-654"])

    list_contacts

    edit_contact("Олег", ["000-111", "222-333"])

    search_contact("Олег")

    delete_contact("Ірина")

    save_to_json
    save_to_yaml

    @contacts = {}
    load_from_json
    load_from_yaml

    list_contacts
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

  def add_contact(name, phones)
    if @contacts.key?(name)
      puts "Контакт вже існує. Додайте або відредагуйте його."
    else
      @contacts[name] = phones
      puts "Контакт '#{name}' додано."
    end
  end

  def edit_contact(name, new_phones)
    if @contacts.key?(name)
      @contacts[name] = new_phones
      puts "Контакт '#{name}' оновлено."
    else
      puts "Контакт не знайдено."
    end
  end

  def delete_contact(name)
    if @contacts.delete(name)
      puts "Контакт '#{name}' видалено."
    else
      puts "Контакт не знайдено."
    end
  end

  def search_contact(query)
    results = @contacts.select { |name, _| name.downcase.include?(query.downcase) }
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
