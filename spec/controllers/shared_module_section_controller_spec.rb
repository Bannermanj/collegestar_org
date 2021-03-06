require 'rails_helper'

RSpec.describe SharedModuleSectionsController do
  describe "POST create" do
    it "should create a new record" do
      expect {
        post :create, params: { shared_module_section: attributes_for(:shared_introduction_section) }
      }.to change { UdlModuleSection.count }.by(1)
    end
    it "should set UdlModuleSection.shared to true" do
      post :create, params: { shared_module_section: attributes_for(:introduction_section) }
      expect(UdlModuleSection.last.shared).to be_truthy
    end
    it "should set UdlModuleSection.default_shared_position" do
      post :create, params: { shared_module_section: attributes_for(:introduction_section) }
      expect(UdlModuleSection.last.default_shared_position).to eq(1)
    end
    it "should set UdlModuleSection.slug" do
      post :create, params: { shared_module_section: { parent: 'introduction', title: 'My New Section', content: 'my content' } }
      expect(UdlModuleSection.last.slug).to eq("my-new-section")
    end
    it "should redirect to /shared-module-section/section-slug/edit" do
      expect( 
        post :create, 
        params: { shared_module_section: attributes_for(:introduction_section) }
      ).to redirect_to(
          edit_shared_module_section_path( slug: "an-intro-section" )
      )
    end
  end

  describe "PATCH update" do
    let(:section) { create(:introduction_section) }
    it "should redirect to edit_shared_module_section_path" do
      section
      patch :update, params: { slug: section.slug, shared_module_section: attributes_for(:introduction_section) }
      expect(response).to redirect_to( edit_shared_module_section_path(section) )
    end
    it "should update the section" do
      section
      new_section_content = "This is the edited content!"
      patch :update, params: { slug: section.slug, shared_module_section: attributes_for(:introduction_section, content: new_section_content) }
      section.reload
      expect(section.content).to eq(new_section_content)
    end
  end

  describe "DELETE destroy" do
    let(:section) { create(:introduction_section) }
    it "should reduce the number of sections by 1" do
      section
      expect {
        delete :destroy, params: { slug: section.slug }
      }.to change { UdlModuleSection.count } .by(-1)
    end
    it "should redirect to udl_modules_path" do
      section
      delete :destroy, params: { slug: section.slug }
      expect(response).to redirect_to(udl_modules_path)
    end
  end
end
