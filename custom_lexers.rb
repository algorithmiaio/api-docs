require 'rouge'
module Rouge
  module Lexers
    class NodeJS < Rouge::Lexers::Javascript
      tag 'nodejs'
      aliases 'node'
    end
  end
end
