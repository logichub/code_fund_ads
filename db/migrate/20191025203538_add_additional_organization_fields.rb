class AddAdditionalOrganizationFields < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :description, :text
    add_column :organizations, :address_1, :string
    add_column :organizations, :address_2, :string
    add_column :organizations, :address_3, :string
    add_column :organizations, :city, :string
    add_column :organizations, :county_province, :string
    add_column :organizations, :zip_or_postcode, :string
    add_column :organizations, :country, :string
    add_column :organizations, :display_in_marketing_pages, :boolean, default: false
  end
end
