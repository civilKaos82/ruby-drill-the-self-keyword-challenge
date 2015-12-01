## CLASS CONTEXT
class Person
  def self.example_class_method
    #We're calling an example class method
    return "Hello from a class method!"
  end

  def self.what_is_self?
    #Here's a class method that prints `self`
    #'self' is always defined.  What is 'self' here?  Let's see.
    return self
  end


  def example_instance_method
    #We're calling an example _instance_ method now.
    return "Hello from an instance method!"
  end

  def what_is_self?
    #'self' is defined here, too, but it means something different.
    #Since we're calling an example *instance* method,
    # `self` is an instance of the class this time.

    #Here's self again
    return self
  end
end

## MODULE CONTEXT
## The following are identical.  Comment each out separately and write the driver code to run the hypot method

module Math
  def self.hypot(a, b)
  # maths in here
  end
end

# module Math
#   def Math.hypot(a, b)
#     # maths in here
#   end
# end
