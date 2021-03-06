require 'spec_helper'

describe 'ActiveMQ server' do

  

  it 'should be running the activemq server' do
    expect(service('activemq')).to be_running
    expect(service('activemq')).to be_enabled
  end

  describe file('/opt/apache-activemq-5.11.0/conf/activemq.xml') do
  	its(:content) {
  		should match /brokerName="vas"/
  	}
  end

  describe file('/opt/apache-activemq-5.11.0/conf/jetty.xml') do
  	its(:content) {
  		should match /property name="port" value="8161"/
  	}
  	its(:content) {
  		should match /property name="contextPath" value="\/VASVASVAS"/
  	}
  	
  end

  describe file('/opt/apache-activemq-5.11.0/conf/jetty-realm.properties') do
  	its(:content) {
  		should match /vas: vas/
  		
  	}
  end

end
