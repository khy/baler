require File.dirname(__FILE__) + '/spec_helper'

class StaticURLGame
  include Baler

  attr_accessor :date

  set_remote_source do |source|
    source.set_url GAME_PATH

    source.map :date => 'html > body > ol > li > span.date'
  end
end

class MultipleURLGame
  include Baler
  
  attr_accessor :date
  
  set_remote_source do |source|
    source.set_url GAME_PATH, ALTERNATE_PATH
    source.set_context 'html > body > ol > li'

    source.map :date => 'span.date'
  end
end

class DynamicURLGame
  include Baler

  attr_accessor :date

  set_remote_source do |source|
    source.set_url ALTERNATE_PATH do |document|
      document.search('h1.global.league').inner_html == 'Major League Baseball' ?
        GAME_PATH : ALTERNATE_PATH
    end

    source.map :date => 'html > body > ol > li > span.date'
  end
end

class MissingURLGame
  include Baler

  attr_accessor :date

  set_remote_source do |source|
    source.map :date => 'html > body > ol > li > span.date'
  end
end

describe 'A class that mixes-in Baler' do
  it 'should use the URL specified within the block' do
    @game = StaticURLGame.new
    @game.gather
    @game.date.should == 'Tuesday, February 3rd'
  end
  
  it 'should gather data across multiple documents' do
    @game = MultipleURLGame.new
    @game.gather :index => 4
    @game.date.should == 'Wednesday, August 4th'
  end

  it 'should build instances across multiple documents' do
    MultipleURLGame.build.size.should == 5
  end

  it 'should use the URL specified within the block' do
    @game = DynamicURLGame.new
    @game.gather
    @game.date.should == 'Tuesday, February 3rd'
  end

  it 'should use the URL specified within the block' do
    @game = MissingURLGame.new
    lambda{@game.gather}.should raise_error(Baler::Remote::Source::URLNotSpecified)
  end
end