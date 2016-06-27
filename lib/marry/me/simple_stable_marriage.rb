require 'marry/me/logger'

module Marry
  module Me
    class SimpleStableMarriage
      # @return [Array<Matchable>] The first pool of potential matches
      attr_reader :pool_one

      # @return [Array<Matchable>] The second pool of potential matches
      attr_reader :pool_two

      # Intializes a new SimpleStableMarriage instance
      # @param pool_one [Array<Matchable>] The first pool of potential matches
      # @param pool_two [Array<Matchable>] The second pool of potential matches
      def initialize(pool_one, pool_two)
        @pool_one = pool_one
        @pool_two = pool_two
      end

      # Attempts to match all of the Matchables in pool's one and two
      # @return [Hash{Matchable => Matchable}] A hash of partnerships
      def match
        pool_one.each(&:reset)
        pool_two.each(&:reset)

        while p1 = pool_one.find(&:unmatched?)
          Marry::Me.logger.debug "Considering #{p1} from pool one"
          potential_partner = pool_two.find { |x| !p1.requested? x }
          raise UnsolvableError, "The given sets are unsolvable, no partner could be found for #{p1}" if potential_partner.nil?
          p1.request_partnership_with potential_partner
        end

        pairs = {}
        pool_one.each { |x| pairs[x] = x.partner }
        pairs
      end
    end
  end
end
