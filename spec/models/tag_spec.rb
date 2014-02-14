require 'spec_helper'

describe Tag do
  let(:tag)       { FactoryGirl.create :tag }

  describe '.return_tag' do
    it 'should return an existing Tag' do
      test_tag = Tag.return_tag tag.name
      expect(tag).to eq test_tag
    end

    it 'should return a new Tag' do
      test_tag = Tag.return_tag tag.name+'2'
      expect(tag).not_to eq test_tag
    end
  end

end
