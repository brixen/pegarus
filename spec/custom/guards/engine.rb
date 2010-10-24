class EngineGuard < SpecGuard
  def match?
    if defined?(RUBY_ENGINE)
      @args.any? { |name| RUBY_ENGINE == name.to_s }
    else
      false
    end
  end
end

class Object
  def engine_is(*names)
    g = EngineGuard.new(*names)
    g.name = :engine_is
    yield if g.yield?
  ensure
    g.unregister
  end

  def engine_is_not(*names)
    g = EngineGuard.new(*names)
    g.name = :engine_is_not
    yield if g.yield? true
  ensure
    g.unregister
  end
end
