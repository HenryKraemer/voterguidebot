require("active_mocker/mock")
class ContestMock < ActiveMocker::Base
  created_with("2.3.0")
  # _modules_constants.erb
  #_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new(id: nil, guide_id: nil, title: nil, description: nil, publish: nil, created_at: nil, updated_at: nil, position: nil).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Integer, guide_id: Integer, title: String, description: String, publish: Axiom::Types::Boolean, created_at: DateTime, updated_at: DateTime, position: Integer }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= { guide: nil, audits: nil, associated_audits: nil, translations: nil, candidates: nil, questions: nil, answers: nil, endorsements: nil, tags: nil }.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= { "Guide" => { belongs_to: [:guide] }, "Audited::Adapters::ActiveRecord::Audit" => { has_many: [:audits, :associated_audits] }, "Contest::Translation" => { has_many: [:translations] }, "Candidate" => { has_many: [:candidates] }, "Question" => { has_many: [:questions] }, "Answer" => { has_many: [:answers] }, "Endorsement" => { has_many: [:endorsements] }, "Tag" => { has_many: [:tags] } }.merge(super)
    end

    def mocked_class
      "Contest"
    end

    private(:mocked_class)
    def attribute_names
      @attribute_names ||= attributes.stringify_keys.keys
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "contests" || super
    end

  end

  # _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end

  def guide_id
    read_attribute(:guide_id)
  end

  def guide_id=(val)
    write_attribute(:guide_id, val)
  end

  def title
    read_attribute(:title)
  end

  def title=(val)
    write_attribute(:title, val)
  end

  def description
    read_attribute(:description)
  end

  def description=(val)
    write_attribute(:description, val)
  end

  def publish
    read_attribute(:publish)
  end

  def publish=(val)
    write_attribute(:publish, val)
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

  def position
    read_attribute(:position)
  end

  def position=(val)
    write_attribute(:position, val)
  end

  # _associations.erb
  # belongs_to
  def guide
    read_association(:guide) || write_association(:guide, classes("Guide").try do |k|
      k.find_by(id: guide_id)
    end)
  end

  def guide=(val)
    write_association(:guide, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :guide_id).item
  end

  def build_guide(attributes = {}, &block)
    association = classes("Guide").try(:new, attributes, &block)
    unless association.nil?
      write_association(:guide, association)
    end

  end

  def create_guide(attributes = {}, &block)
    association = classes("Guide").try(:create, attributes, &block)
    unless association.nil?
      write_association(:guide, association)
    end

  end

  alias_method(:create_guide!, :create_guide)
  # has_many
  def audits
    read_association(:audits, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "auditable_id", foreign_id: self.id, relation_class: classes("Audited::Adapters::ActiveRecord::Audit"), source: "")
    end)
  end

  def audits=(val)
    write_association(:audits, ActiveMocker::HasMany.new(val, foreign_key: "auditable_id", foreign_id: self.id, relation_class: classes("Audited::Adapters::ActiveRecord::Audit"), source: ""))
  end

  def associated_audits
    read_association(:associated_audits, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "associated_id", foreign_id: self.id, relation_class: classes("Audited::Adapters::ActiveRecord::Audit"), source: "")
    end)
  end

  def associated_audits=(val)
    write_association(:associated_audits, ActiveMocker::HasMany.new(val, foreign_key: "associated_id", foreign_id: self.id, relation_class: classes("Audited::Adapters::ActiveRecord::Audit"), source: ""))
  end

  def translations
    read_association(:translations, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "contest_id", foreign_id: self.id, relation_class: classes("Contest::Translation"), source: "")
    end)
  end

  def translations=(val)
    write_association(:translations, ActiveMocker::HasMany.new(val, foreign_key: "contest_id", foreign_id: self.id, relation_class: classes("Contest::Translation"), source: ""))
  end

  def candidates
    read_association(:candidates, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "contest_id", foreign_id: self.id, relation_class: classes("Candidate"), source: "")
    end)
  end

  def candidates=(val)
    write_association(:candidates, ActiveMocker::HasMany.new(val, foreign_key: "contest_id", foreign_id: self.id, relation_class: classes("Candidate"), source: ""))
  end

  def questions
    read_association(:questions, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "contest_id", foreign_id: self.id, relation_class: classes("Question"), source: "")
    end)
  end

  def questions=(val)
    write_association(:questions, ActiveMocker::HasMany.new(val, foreign_key: "contest_id", foreign_id: self.id, relation_class: classes("Question"), source: ""))
  end

  def answers
    read_association(:answers, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "question_id", foreign_id: self.id, relation_class: classes("Answer"), source: "")
    end)
  end

  def answers=(val)
    write_association(:answers, ActiveMocker::HasMany.new(val, foreign_key: "question_id", foreign_id: self.id, relation_class: classes("Answer"), source: ""))
  end

  def endorsements
    read_association(:endorsements, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "endorsed_id", foreign_id: self.id, relation_class: classes("Endorsement"), source: "")
    end)
  end

  def endorsements=(val)
    write_association(:endorsements, ActiveMocker::HasMany.new(val, foreign_key: "endorsed_id", foreign_id: self.id, relation_class: classes("Endorsement"), source: ""))
  end

  def tags
    read_association(:tags, lambda do
      ActiveMocker::HasMany.new([], foreign_key: "tagged_id", foreign_id: self.id, relation_class: classes("Tag"), source: "")
    end)
  end

  def tags=(val)
    write_association(:tags, ActiveMocker::HasMany.new(val, foreign_key: "tagged_id", foreign_id: self.id, relation_class: classes("Tag"), source: ""))
  end

  # _scopes.erb
  module Scopes
    include(ActiveMocker::Base::Scopes)
  end

  extend(Scopes)
  class ScopeRelation < ActiveMocker::Association
    include(ContestMock::Scopes)
  end

  def self.__new_relation__(collection)
    ContestMock::ScopeRelation.new(collection)
  end

  private_class_method(:__new_relation__)
  # _recreate_class_method_calls.erb
  def self.attribute_aliases
    @attribute_aliases ||= {}.merge(super)
  end

  def assign_attributes(attributes)
    call_mock_method(method: __method__, caller: Kernel.caller, arguments: [attributes])
  end

  def full_clone
    call_mock_method(method: __method__, caller: Kernel.caller, arguments: [])
  end

  def full_json
    call_mock_method(method: __method__, caller: Kernel.caller, arguments: [])
  end

  def slim_json
    call_mock_method(method: __method__, caller: Kernel.caller, arguments: [])
  end

  def template(*args, &block)
    call_mock_method(method: __method__, caller: Kernel.caller, arguments: [args, block])
  end

end