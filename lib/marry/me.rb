require 'marry/me/version'
require 'marry/me/simple_stable_marriage'
require 'marry/me/matchable'
require 'marry/me/logger'

module Marry
  module Me
    # Matches the 'partners' in pool_one to their optimal match in pool_two
    # @param pool_one [Array<Matchable>] Pool of partners to match with pool_two
    # @param pool_two [Array<Matchable>] Pool of partners to match with pool_one
    # @param algorithm [Nil, #match] The algorithm that creates matches between partners.
    #   Defaults to the SimpleStableMarriage algorithm, but can be substituted
    #   with any class that accepts two parameters and has a match function
    # @return [Hash { Partner => Partner }] A hash of Partner pairs
    def self.match(pool_one, pool_two, algorithm = SimpleStableMarriage)
      algorithm.new(pool_one, pool_two).match
    end
  end
end
