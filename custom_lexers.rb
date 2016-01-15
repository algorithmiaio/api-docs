require 'rouge'
module Rouge
  module Lexers
    class NodeJS < Rouge::Lexers::Javascript
      tag 'nodejs'
      aliases 'node'
    end
    class CLI < Rouge::Lexers::Shell
      tag 'cli'
      aliases 'algo'
    end
  end
end
