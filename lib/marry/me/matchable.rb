require 'marry/me/logger'

module Marry
  module Me
    module Matchable
      # @return [Matchable, Nil] This Matchcables partner, or Nil if it has none
      attr_accessor :partner

      # @return [Array<Matchable>] The other Matchables that have had been requested for partnerships
      attr_reader :requested

      # Releases this Matchable from its partner
      def free
        @partner = nil
      end

      # clears the stored parternership information
      def reset
        free
        @requested = []
      end

      # Checks if this Matchable has a partner
      # @return [Boolean] True if partnered, false if alone
      def unmatched?
        @partner.nil?
      end

      # Checks if the given Matchable has already been requested as a partner
      # @return [Boolean] True if we have already requested, false if not
      def requested?(matchable)
        (@requested ||= []).include? matchable
      end

      # Checks if the given matchable would be a better partner than the current
      # @return [Boolean] True if the given matchable is better, false if not
      def better_partner?(matchable)
        rank(matchable) > rank(@partner)
      end

      # Marks the two Matchables as partners
      # @param matchable [Matchable] The new partner of this matchable
      def match_with(matchable)
        @partner = matchable
        matchable.partner = self
      end

      # Requests a partnership with the given matchable
      # @param matchable [Matchable] A potential partner
      def request_partnership_with(matchable)
        Marry::Me.logger.debug "#{self} requests a partnership with #{matchable}"
        (@requested ||= []) << matchable
        matchable.respond_to_partnership_request_from(self)
      end

      # Responds to a partnership request from the given matchable
      # @param matchable [Matchable] The requesting partner
      def respond_to_partnership_request_from(matchable)
        if unmatched?
          Marry::Me.logger.debug "#{self} accepts partnership with #{matchable}"
          match_with(matchable)
        elsif better_partner? matchable
          Marry::Me.logger.debug "#{self} has left #{@partner} for #{matchable}"
          @partner.free
          match_with matchable
        else
          Marry::Me.logger.debug "#{self} rejects partnership with #{matchable}"
        end
      end
    end
  end
end
