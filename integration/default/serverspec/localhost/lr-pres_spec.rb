require 'spec_helper'


describe 'epi_tomcat' do 
  
  it "must have tomcat running" do
    expect(service('tomcat7')).to be_running
  end

  it 'should be listening on port 8080' do
    expect(port(8080)).to be_listening
  end  
  
  it 'should have JVM args from the attributes file' do
    ps = `ps -ef | grep tomcat | grep -v grep`
    includesJVMArgs = ps.include?( $node['epi_tomcat']['java_options'] )
    expect(includesJVMArgs).to eq(true)
  end
end
