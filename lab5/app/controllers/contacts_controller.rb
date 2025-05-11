class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update destroy]

  def index
    @contacts = Contact.all
  end

  def show; end

  def new
    @contact = Contact.new
    1.times { @contact.phone_numbers.build }
  end

  def edit
    @contact = Contact.find(params[:id])
    @contact.phone_numbers.build if @contact.phone_numbers.empty?
  end


  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to @contact, notice: 'Контакт створено успішно.'
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: 'Контакт оновлено успішно.'
    else
      render :edit
    end
  end

  def destroy
    print "qwe"
    @contact.destroy
    redirect_to contacts_path, notice: 'Контакт видалено успішно.'
  end


  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, phone_numbers_attributes: [:id, :number, :_destroy])
  end
end
