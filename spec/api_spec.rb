require File.dirname(__FILE__) + '/spec_helper'

class APIGame
  include Baler
end

describe 'A class that mixes-in Baler' do
  it 'should have the method .set_remote_source' do
    APIGame.should respond_to(:set_remote_source)
  end
  
  it 'should have the method .build' do
    APIGame.should respond_to(:build)
  end
  
  it 'should have the method .build_or_update' do
    APIGame.should respond_to(:build_or_update)
  end
  
  it 'should have the method #gather' do
    APIGame.new.should respond_to(:gather)
  end
end
