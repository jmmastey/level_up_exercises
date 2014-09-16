# File response_format.rb
# encoding: UTF-8

module Sinatra
  module BombHelpers
    WireResponse = Struct.new(:status, :message)

    def create_wires(number_of_wires)
      wires = []
      speed_down_wire,
          speed_up_wire,
          diffusing_wire,
          detonating_wire = (0..number_of_wires.to_i).to_a.sample(4)
      number_of_wires.times do |wire_num|
        detonates = equal_wires?(wire_num, detonating_wire)
        speed_up = equal_wires?(wire_num, speed_up_wire)
        speed_down = equal_wires?(wire_num, speed_down_wire)
        diffuses = equal_wires?(wire_num, diffusing_wire)
        wires << Wire.new(color: '%06x' % (rand * 0xffffff),
                          detonates: detonates, speeds_up: speed_up,
                          speeds_down: speed_down, diffuses: diffuses)
      end
      wires
    end

    def cut_wire_response(bomb, status, accept)
      bomb.status = status.status[:status]
      bomb.save
      format_response(status.status, accept)
    end

    def cut_wire_status(wire)
      return WireResponse.new(status: :exploded,
                              message: 'BOOM') if wire.detonates
      return WireResponse.new(status: :defused,
                              message: 'SUCCESS') if wire.diffuses
      return WireResponse.new(status: :active,
                              message: 'SPEED_UP') if wire.speeds_up
      return WireResponse.new(status: :active,
                              message: 'SPEED_DOWN') if wire.speeds_down
      WireResponse.new(status: :active,
                       message: 'INERT') if wire.inert?
    end

    private

    def equal_wires?(num, wire)
      num.equal?(wire)
    end

    def invalid_activation(bomb)
      status 400
      bomb_error = { id: bomb.id, status: bomb.status, attemps: bomb.attempts,
                     detonation_time: bomb.detonation_time,
                     error: 'Invalid Activation Code' }
      format_response(bomb_error, request.accept)
    end

    def valid_activation(bomb)
      unless bomb.status == :active
        bomb.status = :active
        bomb.save || halt(404)
      end
      format_bomb(bomb)
    end

    def invalid_deactivation(bomb)
      bomb.attempts += 1
      bomb.save
      if bomb.attempts.eql?(3)
        detonate_bomb(bomb)
      else
        status 400
        bomb_error = { id: bomb.id, status: bomb.status,
                       attempts: bomb.attempts,
                       detonation_time: bomb.detonation_time,
                       error: 'Invalid Deactivation Code' }
        format_response(bomb_error, request.accept)
      end
    end

    def valid_deactivation(bomb)
      if bomb.status == :active
        bomb.status = :inactive
        bomb.save || halt(404)
      end
      format_bomb(bomb)
    end

    def detonate_bomb(bomb)
      bomb.status = :exploded
      format_bomb(bomb)
    end
  end
  helpers BombHelpers
end
