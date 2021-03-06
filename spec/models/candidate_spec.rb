require 'rails_helper'

RSpec.describe Candidate, type: :model do

  context '#assign_attributes' do
    let(:endorsements) do
      [Fabricate.build(:endorsement, endorser: 'great').as_json]
    end
    let(:raw) do
      { name: 'Boby Shrum', party: 'Democrat', endorsements: endorsements }
    end
    it 'assigns regular attributes' do
      subject.assign_attributes raw
      expect(subject.name).to eq(raw[:name])
    end
    it 'assigns party' do
      subject.assign_attributes raw
      expect(subject.party).to eq(raw[:party])
    end
    it 'assigns endorsements' do
      subject.assign_attributes raw
      expect(subject.endorsements.first.endorser).to eq(raw[:endorsements].first[:endorser])
    end
    context 'with already existing endorsements' do
      let(:endorsements) do
        [
          Fabricate.build(:endorsement, endorser: 'great', stance: 'for').as_json,
          Fabricate(:endorsement, endorser: 'great', stance: 'for', endorsed: subject ).as_json
        ]
      end
      it 'assigns endorsements' do
        subject.assign_attributes raw
        expect(subject.endorsements.last.endorser).to eq(raw[:endorsements].first[:endorser])
      end
      it 'deletes missing endorsements' do
        subject.assign_attributes raw.update(endorsements: [endorsements.first])
        expect(subject.endorsements.length).to eq(1)
      end
      it 'reorders endorsements' do
        subject.assign_attributes raw
        subject.save!
        subject.reload
        expect(subject.endorsements.last.id).to eq endorsements.last['id']
        expect(subject.endorsements.last.position).to eq 1
      end
    end
  end

end
