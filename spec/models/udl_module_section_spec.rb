require 'spec_helper'

RSpec.describe UdlModuleSection do
  
  describe "validations" do
    it { should validate_presence_of(:title) }
  end
  describe "associations" do
    it "has many modules" do
      is_expected.to have_many(:modules).through(:module_section_associations)
    end
    it "has many module_section_associations" do
      is_expected.to have_many(:module_section_associations)
    end
  end

  describe "#position" do
    let(:udl_module) { create(:udl_module) }
    let(:udl_module_section) { create(:udl_module_section) }
    context "given a module_id and parent page" do
      it "should return the correct position" do
        udl_module.add_section( udl_module_section )
        expect(
          udl_module_section.position( module: udl_module )
        ).to eq(1)
      end
    end
  end

  describe "#shared_sections" do
    let(:intro_section) { create(:shared_introduction_section) }
    let(:udl_section) { create(:shared_udl_principles_section) }
    let(:instructional_section) { create(:shared_instructional_practice_section) }
    let(:lit_section) { create(:shared_literature_base_section) }
    let(:learn_section) { create(:shared_learn_more_section) }
    let(:references_section) { create(:shared_references_and_resources_section) }
    let(:shared_sections) { UdlModuleSection.shared_sections}
    let(:result) { 
      {
        introduction: [intro_section],
        udl_principles: [udl_section],
        instructional_practice: [instructional_section],
        literature_base: [lit_section],
        learn_more: [learn_section],
        references_and_resources: [references_section]

      }
    }
    it "should return hash of shared sections by page" do
      expect(shared_sections).to eq(result)
    end
  end

  describe "#set_shared_section_default_position" do
    let(:shared_introduction_section) { create(:shared_introduction_section) }
    let(:second_shared_introduction_section) { build(:shared_introduction_section) }
    it "should return the current number of shared sections with given parent" do
      shared_introduction_section
      UdlModuleSection.set_shared_section_default_position( section: second_shared_introduction_section )
      expect( second_shared_introduction_section.default_shared_position ).to eq(2)
    end
    it "should return 1 if no sections exist" do
      expect(
        UdlModuleSection.set_shared_section_default_position( section: second_shared_introduction_section )
      ).to eq(1)
    end
  end

  describe "#find_module_section" do
    let(:udl_module) { create(:udl_module) }
    let(:section) {  create(:introduction_section, title: 'test', slug: 'test') }
    let(:section_with_same_slug) { create(:introduction_section, title: 'test', slug: 'test') }
    it "finds a section by slug and udl_module" do
      udl_module.add_section( section )
      udl_module.save
      section_with_same_slug

      expect( 
        UdlModuleSection.find_module_section(module_slug: udl_module.slug, section_slug: section.slug)
      ).to eq(section)
    end
  end
end
