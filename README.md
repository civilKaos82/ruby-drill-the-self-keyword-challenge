# Ruby Drill: The Self Keyword

## Summary
There is a keyword in Ruby called `self`. We're going to explore `self` in this challenge.  It can be difficult to understand the `self` keyword, but our understanding of it will grow as we become more practiced rubyists.

```ruby
name = "Malachi"
# => "Malachi"
name.upcase
# => "MALACHI"
```
*Figure 1*. Calling a method on an specific object, referenced through a variable.

We're used to defining variables in our programs.  When we assign an object to a variable, we can later reference the object through the variable (see Figure 1).  The `self` keyword works similarly to a variable in that it also references an object.  However, the object to which `self` points changes at different points in our program.

To which object does `self` point?  Remember, when we call a method, we're sending a message to an object.  In Figure 1, when we call `name.upcase`, we're sending the message `:upcase` to a specific object, a string that we're referencing through the variable `name`.

```ruby
object_id
# => 2155958780
```
*Figure 2*.  Calling the `:object_id` method without explicitly stating which object should receive the message.

However, we sometimes call a method without calling it directly on an object.  In Figure 2, we call the `:object_id` method, but we don't explicitly state to which object we're sending the message.  So, to which object is this message sent?  The message is sent to the object to which `self` points.  In other words, when we call a method, `self` is the default receiver.

In the *Releases* section we'll explore to which object `self` refers at different contexts of our program, and how we can utilize it.


## Releases
### Release 0: Within Method Definitions
When we define methods, we're writing code that will be executed at a later time when the method is called.  In addition, the method executes in a new context, or scope.  While the code in the method body is executing in this new scope, `self` refers to the receiver of the method call (i.e., the method on which the object was called).

We have a class `Person` with instance methods that demonstrate this.  First, there is the method `#return_self`, which simply returns the object to which `self` points when the method executes.  The test suite demonstrates that this method returns the exact same object on which the method was called.

Second, we have the method `#full_name`, which combines and returns the person's first and last names.  We can see that the method calls the `#first_name` and `#last_name` attribute reader methods on `self`, which is the object on which the method is called.

```ruby
class Person
  def full_name
    "#{first_name} #{last_name}"
  end
  
  # Rest of class omitted ...
end
```
*Figure 3*. Using `self` as the default receiver of method calls.

Remember that `self` is the default receiver of method calls.  If we call a method without specifying an object on which we're calling the method, the message is sent to `self`.  To demonstrate this, refactor the `#full_name` method to match Figure 3—we're removing the explicit receiver from our method calls.  The method will behave just as it did before.

If we want to explore these methods more, we can open IRB and `load 'person.rb'`  Then we can create some instances of the class `Person` and call these methods on them.


### Release 1: When Defining a Class
When we define a class, that class is itself an object.  Like any other object, a `Class` object is capable of having messages sent to it.  We regularly send them the message `:new`.

Sometimes we want our classes to perform additional behaviors.  To accomplish this, we can define methods on a class itself.  We call these *class methods*.  We have a class object `Dog` that has a class method defined on it: the method `.create_multiple` creates multiple dogs based on an array of data.

```ruby
class Dog
  def Dog.create_multiple(data_for_multiple_dogs)
    data_for_multiple_dogs.map { |data_for_one_dog| Dog.new(data_for_one_dog) }
  end
  
  # Rest of class omitted ...
end
```
*Figure 4*.  Defining a class method within the body of the class definition.

What does this have to do with the keyword `self`?  To set up for that discussion, let's do a little refactoring.  When we define a class method, we typically do so within the body of the class definition; this keeps our code well organized.  Let's refactor our `Dog` class, so that the class method `.create_multiple` is defined within the class definition (see Figure 4).  Our tests for the `Dog` class should continue to pass.

Now that we're defining our class method within the body of the class definition, we can discuss `self`.  When Ruby encounters a class definition, the code in the class definition is executed, and while it's executed the `self` keyword will point to the `Class` object being defined.

```ruby
class Dog
  def self.create_multiple(data_for_multiple_dogs)
    data_for_multiple_dogs.map { |data_for_one_dog| Dog.new(data_for_one_dog) }
  end
  
  # Rest of class omitted ...
end
```
*Figure 5*.  Defining a class method within the body of the class definition, using the keyword `self`.

To demonstrate this, let's perform an additional refactor.  Rather than defining the class method `.create_multiple` explicitly on the object `Dog`, let's define it on `self` (see Figure 5).  As with our previous refactor, our tests should continue to pass.  After all, in this example, `self` is pointing to the object `Dog`.


### Release 2:  When Defining a Module
```ruby
Math.sqrt(4)
# => 2.0
Math.hypot(3, 4)
# => 5.0 
```  
*Figure 6*. Calculating using the `Math` module.

Modules in Ruby are used in different ways.  One way to utilize a module is as an object that performs a set of related behaviors.  For example, Ruby provides a `Math` module.  In Figure 6, we can see that we can call methods directly on the module itself.  We can ask the `Math` module to calculate the square root of a number or the length of a triangle's hypotenuse given the lengths of its legs.

We're going to define our own module `AreaCalculator` which will calculate the areas of shapes.  Tests are written for the module's behaviors; we need to define the methods.  If our geometry is rusty, we can see how to calculate each shape's area in the tests; this release isn't about geometry, rather it's about using `self` within the body of a module definition.

We define modules in the same way that we define classes—in fact, a class is a specific type of module.  Only, instead of beginning with `class`, we begin with `module`.  As with defining a class, when we define a module we're creating an object on which we can define methods (i.e., add behaviors).

`self` is treated the same way in the body of a module definition as it is in a class definition.  `self` points to the new module being defined.  So, as we're defining a module, we can utilize `self` to add methods to the module, just as we did in adding the method `.create_multiple` to our `Dog` class in Release 1.

Let's add some behaviors to the `AreaCalculator` module.  Again, the behaviors we're looking for have been described in the test suite:  calculating the area of rectangles, squares, and triangles.









### Release 3: The Global Context
There is a global context in which our Ruby programs execute, and within this context exists a special instance of the class `Object` called `main`.  In the global context, `self` points to main.

```bash
2.1.0 :001 > self
# => main 
2.1.0 :002 > def return_receiver_of_method_call
2.1.0 :003?>   return self
2.1.0 :004?>   end
# => :return_receiver_of_method_call 
2.1.0 :005 > return_receiver_of_method_call
# => main 
```
*Figure 3*.  Exploring the global-context `self` in IRB.

We can explore `self` in the global context by opening IRB.  In Figure 3, we're in IRB.  We first access `self`, which returns `main`, demonstrating that in the global context.



There is the global or "main" context, which you can see by executing `self.to_s` or `self.public_methods` in IRB.

Try this now.  What are some of the methods available?

#### Class Context

Consider this code:

```ruby
class ClassMethodExample
  def self.example_class_method
    puts "We're calling an example class method"
    puts "'self' is always defined.  What is 'self' here?  Let's see."
    p self
    puts "That was self!"
  end

  def example_instance_method
    puts "We're calling an example *instance* method"
    puts "'self' is defined here, too, but it means something different."
    p self
    puts "That was self, again, but see how it's an instance of the class."
  end
end
```

We've defined two methods, here: a class method and an instance method.  `self` references something different depending on the context.  In the class method context, `self` refers to the class itself.  In the instance method context, `self` refers to the particular instance of the class.

Load `self.rb` up in IRB. Run `irb` from the `source` directory, then `load "self.rb"`.

Play around with the methods. How do you call them? What does each return? Why?

Write tests for **each** of the methods on `Person`

#### Module Context

You can also use self when you want to create "class methods", like `Math.hypot(3, 4)` in a Module.

```ruby
module Math
  def self.hypot(a, b)
    # maths in here
  end
end
```

This is identical to using the module explicitly:

```ruby
module Math
  def Math.hypot(a, b)
    # maths in here
  end
end
```

In this context, `self` _is_ the class, and most Rubyists use `self` to define class methods.

Implement `#hypot` and then write a test for it. When the test passes, comment out the first definition of `#hypot` and uncomment the second (make sure you feel in the contents of `#hypot`). You should see that the test passes because the definitions are equivalent.

###Release 1: Write it up

After reading this challenge and practicing with `self` you should have a solid understanding of it. Write up an explanation of self in your own words, and submit it as comments at in the `self.rb` file.  Make sure even your deaf grandma would understand it!

##Resources

[self article]: http://yugui.jp/articles/846

