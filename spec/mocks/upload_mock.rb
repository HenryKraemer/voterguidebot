require("active_mocker/mock")
class UploadMock < ActiveMocker::Base
  created_with("2.2.2")
  # _modules_constants.erb
  #_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new("id" => nil, "user_id" => nil, "created_at" => nil, "updated_at" => nil, "file_file_name" => nil, "file_content_type" => nil, "file_file_size" => nil, "file_updated_at" => nil).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, user_id: Fixnum, created_at: DateTime, updated_at: DateTime, file_file_name: String, file_content_type: String, file_file_size: Fixnum, file_updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= { user: nil }.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= { "User" => { belongs_to: [:user] } }.merge(super)
    end

    def mocked_class
      "Upload"
    end

    private(:mocked_class)
    def attribute_names
      @attribute_names ||= (["id", "user_id", "created_at", "updated_at", "file_file_name", "file_content_type", "file_file_size", "file_updated_at"] | super)
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "uploads" || super
    end

  end

  # _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end

  def user_id
    read_attribute(:user_id)
  end

  def user_id=(val)
    write_attribute(:user_id, val)
  end

  def created_at
    read_attribute(:created_at)
  end

  def created_at=(val)
    write_attribute(:created_at, val)
  end

  def updated_at
    read_attribute(:updated_at)
  end

  def updated_at=(val)
    write_attribute(:updated_at, val)
  end

  def file_file_name
    read_attribute(:file_file_name)
  end

  def file_file_name=(val)
    write_attribute(:file_file_name, val)
  end

  def file_content_type
    read_attribute(:file_content_type)
  end

  def file_content_type=(val)
    write_attribute(:file_content_type, val)
  end

  def file_file_size
    read_attribute(:file_file_size)
  end

  def file_file_size=(val)
    write_attribute(:file_file_size, val)
  end

  def file_updated_at
    read_attribute(:file_updated_at)
  end

  def file_updated_at=(val)
    write_attribute(:file_updated_at, val)
  end

  # _associations.erb
  # belongs_to
  def user
    read_association(:user) || write_association(:user, classes("User").try do |k|
      k.find_by(id: user_id)
    end)
  end

  def user=(val)
    write_association(:user, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :user_id).item
  end

  def build_user(attributes = {}, &block)
    association = classes("User").try(:new, attributes, &block)
    unless association.nil?
      write_association(:user, association)
    end

  end

  def create_user(attributes = {}, &block)
    association = classes("User").try(:create, attributes, &block)
    unless association.nil?
      write_association(:user, association)
    end

  end

  alias_method(:create_user!, :create_user)
  # _scopes.erb
  module Scopes
    include(ActiveMocker::Base::Scopes)
  end

  extend(Scopes)
  class ScopeRelation < ActiveMocker::Association
    include(UploadMock::Scopes)
  end

  def self.__new_relation__(collection)
    UploadMock::ScopeRelation.new(collection)
  end

  private_class_method(:__new_relation__)
  # _recreate_class_method_calls.erb
  def self.attribute_aliases
    @attribute_aliases ||= {}.merge(super)
  end

end