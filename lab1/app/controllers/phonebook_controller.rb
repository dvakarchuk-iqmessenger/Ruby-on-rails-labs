require 'json'
require 'yaml'

class PhonebookController < ApplicationController
  before_action :load_contacts

  FILE_PATH_JSON = Rails.root.join('storage', 'contacts.json')
  FILE_PATH_YAML = Rails.root.join('storage', 'contacts.yaml')

  def index
    @contacts = @@contacts || {}
  end

  def add
    name = params[:name]
    numbers = params[:numbers].split(',').map(&:strip)
    @@contacts[name] = numbers
    redirect_to root_path
  end

  def edit
    old_name = params[:old_name]
    new_name = params[:name]
    numbers = params[:numbers].split(',').map(&:strip)
    @@contacts.delete(old_name)
    @@contacts[new_name] = numbers
    redirect_to root_path
  end

  def delete
    @@contacts.delete(params[:name])
    redirect_to root_path
  end

  def search
    term = params[:term].downcase
    @contacts = @@contacts.select { |name, _| name.downcase.include?(term) }
    render :index
  end

  def saveJson
    File.write(FILE_PATH_JSON, JSON.pretty_generate(@@contacts))
    redirect_to root_path
  end

  def saveYaml
    File.write(FILE_PATH_YAML, YAML.dump(@@contacts))
    redirect_to root_path
  end

  def loadJson
    if File.exist?(FILE_PATH_JSON)
      @@contacts = JSON.parse(File.read(FILE_PATH_JSON))
    end
    redirect_to root_path
  end

  def loadYaml
    if File.exist?(FILE_PATH_YAML)
      @@contacts = YAML.load_file(FILE_PATH_YAML)
    end
    redirect_to root_path
  end

  private

  def load_contacts
    @@contacts ||= {}
  end
end
