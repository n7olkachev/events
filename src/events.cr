require "./events/*"

module Events
  module Emitter
    macro emits(event, *args)
      @{{ event.id }}_handlers = [] of Proc({{ *args.map &.type}}, Nil)
      def emit_{{ event.id }}({{ *args }})
        @{{ event.id }}_handlers.each do |handler|
          handler.call {{ *args.map &.var.id }}
        end
      end

      def on_{{ event.id }}(&block : {{ *args.map &.type }} ->)
        @{{ event.id }}_handlers << block
      end
    end

    macro emit(event, *args)
        emit_{{ event.id }} {{ *args }}
    end
  end
end
