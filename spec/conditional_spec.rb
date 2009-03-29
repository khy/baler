require File.dirname(__FILE__) + '/spec_helper'

class ConditionalGame
  include Baler
  
  attr_accessor :home_team
  attr_accessor :a, :b, :c, :d, :e, :f
    
  set_remote_source File.dirname(__FILE__) + '/samples/game.html' do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :home_team => 'html > body > ol > li > span.team.home'
    
    source.gather_if {|game| game.a == 1}
    source.gather_if :b_equals_two, :c_equals_three
    
    source.gather_unless{|game| game.d == 4}
    source.gather_unless :e_equals_five, :f_equals_six
  end
  
  def initialize
    @home_team = 'Houston Rockets'
    @home_score = 92
  end
  
  def c_equals_three; @c == 3; end
  def e_equals_five; @e == 5; end
  
  protected
    def b_equals_two; @b == 2; end
  
  private
    def f_equals_six; @f == 6; end
end

describe 'Baler conditional gather functionality' do
  before(:each) do
    @game = ConditionalGame.new
    @game.a = 1
    @game.b = 2
    @game.c = 3
  end
  
  describe '#gather' do
    it 'should gather as expected when all \'if\' conditions are true 
          and all \'unless\' conditions are false' do
      @game.gather(0)
      @game.home_team.should == 'Los Angeles Lakers'
    end
    
    it 'should not gather if any \'if\' condition is false' do
      @game.a = 2
      @game.gather(0)
      @game.home_team.should == 'Houston Rockets'
      @game.a == 1
      
      @game.b = 1
      @game.gather(0)
      @game.home_team.should == 'Houston Rockets'
    end
    
    it 'should not gather if any \'unless\' condition is true' do
      @game.d = 4
      @game.gather(0)
      @game.home_team.should == 'Houston Rockets'
      @game.d == nil
      
      @game.f = 6
      @game.gather(0)
      @game.home_team.should == 'Houston Rockets'
    end
    
    it 'should ignore \'if\' and \'unless\' conditions if forced' do
      @game.c = 1
      @game.e = 5
      @game.gather(0, :force => true)
      @game.home_team.should == 'Los Angeles Lakers'
    end
  end
  
  describe '#build' do
    it 'should not be affected by \'if\' and \'unless\' conditions' do
      games = ConditionalGame.build
      games.length.should == 3
      games[0].home_team.should == 'Los Angeles Lakers'
    end
  end
end
      